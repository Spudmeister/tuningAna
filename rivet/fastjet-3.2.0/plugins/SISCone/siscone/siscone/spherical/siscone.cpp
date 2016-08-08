///////////////////////////////////////////////////////////////////////////////
// File: siscone.cpp                                                         //
// Description: source file for the main SISCone class                       //
// This file is part of the SISCone project.                                 //
// WARNING: this is not the main SISCone trunk but                           //
//          an adaptation to spherical coordinates                           //
// For more details, see http://projects.hepforge.org/siscone                //
//                                                                           //
// Copyright (c) 2006-2008 Gavin Salam and Gregory Soyez                     //
//                                                                           //
// This program is free software; you can redistribute it and/or modify      //
// it under the terms of the GNU General Public License as published by      //
// the Free Software Foundation; either version 2 of the License, or         //
// (at your option) any later version.                                       //
//                                                                           //
// This program is distributed in the hope that it will be useful,           //
// but WITHOUT ANY WARRANTY; without even the implied warranty of            //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             //
// GNU General Public License for more details.                              //
//                                                                           //
// You should have received a copy of the GNU General Public License         //
// along with this program; if not, write to the Free Software               //
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA //
//                                                                           //
// $Revision:: 395                                                          $//
// $Date:: 2016-03-16 11:44:47 +0100 (Wed, 16 Mar 2016)                     $//
///////////////////////////////////////////////////////////////////////////////

//#ifdef HAVE_CONFIG_H
#include <siscone/config.h>
//#else
//#define PACKAGE_NAME "SISCone"
//#define VERSION "3.0.2"
//#warning "No config.h file available, using preset values"
//#endif

#include <siscone/ranlux.h>
#include <siscone/siscone_error.h>
#include <siscone/defines.h>
#include "momentum.h"
#include "siscone.h"
#include <iostream>
#include <sstream>
#include <iomanip>

namespace siscone_spherical{
using namespace std;

/***************************************************************
 * CSphsiscone implementation                                  *
 * final class: gather everything to compute the jet contents. *
 *                                                             *
 * This is the class user should use.                          *
 * It computes the jet contents of a list of particles         *
 * given a cone radius and a threshold for splitting/merging.  *
 ***************************************************************/

// default ctor
//--------------
CSphsiscone::CSphsiscone(){
  rerun_allowed = false;
}

// default dtor
//--------------
CSphsiscone::~CSphsiscone(){
  rerun_allowed = false;
}

bool CSphsiscone::init_done=false;
std::ostream* CSphsiscone::_banner_ostr=&cout;

/*
 * compute the jets from a given particle set doing multiple passes
 * such pass N looks for jets among all particles not put into jets
 * during previous passes.
 *  - _particles   list of particles
 *  - _radius      cone radius
 *  - _f           shared energy threshold for splitting&merging
 *  - _n_pass_max  maximum number of runs
 *  - _Emin        minimum energy of the protojets
 *  - _split_merge_scale    the scale choice for the split-merge procedure
 *    NOTE: using pt leads to IR unsafety for some events with momentum
 *          conservation. So we strongly advise not to change the default
 *          value.
 * return the number of jets found.
 **********************************************************************/
int CSphsiscone::compute_jets(vector<CSphmomentum> &_particles, double _radius, double _f, 
			      int _n_pass_max, double _Emin,
			      Esplit_merge_scale _split_merge_scale){
  // make sure things are initialised
  _initialise_if_needed();

  // run some general safety tests (NB: f will be checked in split-merge)
  if (_radius <= 0.0 || _radius >= 0.5*M_PI) {
    ostringstream message;
    message << "Illegal value for cone radius, R = " << _radius 
            << " (legal values are 0<R<pi/2)";
    throw siscone::Csiscone_error(message.str());
  }



  ptcomparison.split_merge_scale = _split_merge_scale;
  partial_clear(); // make sure some things are initialised properly

  // init the split_merge algorithm with the initial list of particles
  // this initialises particle list p_left of remaining particles to deal with
  init_particles(_particles);

  bool finished = false;

  rerun_allowed = false;
  protocones_list.clear();

#ifdef DEBUG_STABLE_CONES
  nb_hash_cones_total = 0;
  nb_hash_occupied_total = 0;
#endif

  do{
    // initialise stable_cone finder
    // here we use the list of remaining particles
    // AFTER COLLINEAR CLUSTERING !!!!!!
    CSphstable_cones::init(p_uncol_hard);

    // get stable cones
    if (get_stable_cones(_radius)){
      // we have some new protocones.
      // add them to candidates
      protocones_list.push_back(protocones);
      add_protocones(&protocones, R2, _Emin);
#ifdef DEBUG_STABLE_CONES
      nb_hash_cones_total += nb_hash_cones;
      nb_hash_occupied_total += nb_hash_occupied;
#endif
    } else {
      // no new protocone: leave
      finished=true;
    }

    _n_pass_max--;
  } while ((!finished) && (n_left>0) && (_n_pass_max!=0));

  rerun_allowed = true;

  // split & merge
  return perform(_f, _Emin);
}

/*
 * compute the jets from a given particle set doing multiple passes
 * such pass N looks for jets among all particles not put into jets
 * during previous passes.
 *  - _particles   list of particles
 *  - _radius      cone radius
 *  - _n_pass_max  maximum number of runs
 *  - _Emin        minimum energy of the protojets
 *  - _ordering_scale    the ordering scale to decide which stable
 *                       cone is removed
 * return the number of jets found.
 **********************************************************************/
int CSphsiscone::compute_jets_progressive_removal(vector<CSphmomentum> &_particles, double _radius, 
					       int _n_pass_max, double _Emin,
					       Esplit_merge_scale _ordering_scale){
  // make sure things are initialised
  _initialise_if_needed();

  // run some general safety tests (NB: f will be checked in split-merge)
  if (_radius <= 0.0 || _radius >= 0.5*M_PI) {
    ostringstream message;
    message << "Illegal value for cone radius, R = " << _radius 
            << " (legal values are 0<R<pi/2)";
    throw siscone::Csiscone_error(message.str());
  }

  ptcomparison.split_merge_scale = _ordering_scale;
  partial_clear(); // make sure some things are initialised properly

  // init the split_merge algorithm with the initial list of particles
  // this initialises particle list p_left of remaining particles to deal with
  //
  // this stores the "processed" particles in p_uncol_hard
  init_particles(_particles);
  jets.clear();

  bool unclustered_left;
  rerun_allowed = false;
  protocones_list.clear();

  do{
    //cout << n_left << " particle left" << endl; 

    // initialise stable_cone finder
    // here we use the list of remaining particles
    // AFTER COLLINEAR CLUSTERING !!!!!!
    CSphstable_cones::init(p_uncol_hard);

    // get stable cones (stored in 'protocones')
    unclustered_left = get_stable_cones(_radius);

    // add the hardest stable cone to the list of jets
    if (add_hardest_protocone_to_jets(&protocones, R2, _Emin)) break;
  
    _n_pass_max--;
  } while ((unclustered_left) && (n_left>0) && (_n_pass_max!=0));

  // split & merge
  return jets.size();
}
/*
 * recompute the jets with a different overlap parameter.
 * we use the same particles and R as in the preceeding call.
 *  - _f           shared energy threshold for splitting&merging
 *  - _Emin        minimum Energy of the protojets
 *  - _split_merge_scale    the scale choice for the split-merge procedure
 *    NOTE: using pt leads to IR unsafety for some events with momentum
 *          conservation. So we strongly advise not to change the default
 *          value.
 * return the number of jets found, -1 if recomputation not allowed.
 ********************************************************************/
int CSphsiscone::recompute_jets(double _f, double _Emin,
				Esplit_merge_scale _split_merge_scale){
  if (!rerun_allowed)
    return -1;

  ptcomparison.split_merge_scale = _split_merge_scale;

  // restore particle list
  partial_clear();
  init_pleft();

  // initialise split/merge algorithm
  unsigned int i;
  for (i=0;i<protocones_list.size();i++)
    add_protocones(&(protocones_list[i]), R2, _Emin);

  // split & merge
  return perform(_f, _Emin);
}  


// make sure things are initialised
void CSphsiscone::_initialise_if_needed(){
  // initialise random number generator
  if (init_done) return;

  // initialise random number generator
  siscone::ranlux_init();

  // do not do this again
  init_done=true;

  // print the banner
  if (_banner_ostr != 0){
    ios::fmtflags flags_to_restore(_banner_ostr->flags());

    (*_banner_ostr) << "#ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo" << endl;
    (*_banner_ostr) << "#                    SISCone   version " << setw(28) << left << siscone_version() << "o" << endl;
    (*_banner_ostr) << "#              http://projects.hepforge.org/siscone                o" << endl;
    (*_banner_ostr) << "#                                                                  o" << endl;
    (*_banner_ostr) << "# This is SISCone: the Seedless Infrared Safe Cone Jet Algorithm   o" << endl;
    (*_banner_ostr) << "# SISCone was written by Gavin Salam and Gregory Soyez             o" << endl;
    (*_banner_ostr) << "# It is released under the terms of the GNU General Public License o" << endl;
    (*_banner_ostr) << "#                                                                  o" << endl;
    (*_banner_ostr) << "#            !!!             WARNING            !!!                o" << endl;
    (*_banner_ostr) << "#    This is the version of SISCone using spherical coordinates    o" << endl;
    (*_banner_ostr) << "#                                                                  o" << endl;
    (*_banner_ostr) << "# A description of the algorithm is available in the publication   o" << endl;
    (*_banner_ostr) << "# JHEP 05 (2007) 086 [arXiv:0704.0292 (hep-ph)].                   o" << endl;
    (*_banner_ostr) << "# Please cite it if you use SISCone.                               o" << endl;
    (*_banner_ostr) << "#ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo" << endl;
    (*_banner_ostr) << endl;

    _banner_ostr->flush();
    _banner_ostr->flags(flags_to_restore);
  }
}

// finally, a bunch of functions to access to 
// basic information (package name, version)
//---------------------------------------------

/* 
 * return SISCone package name.
 * This is nothing but "SISCone", it is a replacement to the
 * PACKAGE_NAME string defined in config.h and which is not
 * public by default.
 * return the SISCone name as a string
 */
string siscone_package_name(){
  return PACKAGE_NAME;
}

/* 
 * return SISCone version number.
 * return a string of the form "X.Y.Z" with possible additional tag
 *        (alpha, beta, devel) to mention stability status
 */
string siscone_version(){
  return VERSION;
}

}
