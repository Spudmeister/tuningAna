// -*- C++ -*-
//
// This file is part of YODA -- Yet more Objects for Data Analysis
// Copyright (C) 2008-2015 The YODA collaboration (see AUTHORS for details)
//
#ifndef YODA_STRINGUTILS_H
#define YODA_STRINGUTILS_H

#include <sstream>

namespace YODA {
  namespace Utils {


    /// Generic convenient conversion to string
    template <typename T>
    inline std::string toStr(const T& x) {
      std::ostringstream ss; ss << x;
      return ss.str();
    }


    /// Replace XML reserved characters with &XXXX; encodings
    inline std::string encodeForXML(const std::string& in) {
      std::string out = in;
      typedef std::pair<std::string, std::string> CharsToEntities;
      std::vector<CharsToEntities> cs2es;
      cs2es.push_back(std::make_pair("&", "&amp;"));
      cs2es.push_back(std::make_pair("<", "&lt;"));
      cs2es.push_back(std::make_pair(">", "&gt;"));

      for (std::vector<CharsToEntities>::const_iterator c2e = cs2es.begin(); c2e != cs2es.end(); ++c2e) {
        std::string::size_type pos = -1;
        while ( ( pos = out.find(c2e->first, pos + 1) ) != std::string::npos ) {
          out.replace(pos, 1, c2e->second);
        }
      }
      return out;
    }


    /// In-place trim from start
    inline std::string& iltrim(std::string& s) {
      s.erase(s.begin(), std::find_if(s.begin(), s.end(), std::not1(std::ptr_fun<int, int>(std::isspace))));
      return s;
    }

    /// In-place trim from end
    inline std::string& irtrim(std::string& s) {
        s.erase(std::find_if(s.rbegin(), s.rend(), std::not1(std::ptr_fun<int, int>(std::isspace))).base(), s.end());
        return s;
    }

    /// In-place trim from both ends
    inline std::string& itrim(std::string& s) {
      return iltrim(irtrim(s));
    }


    /// Trim from start
    inline std::string ltrim(const std::string& s) { //< @note Could just pass by value, but const& sends a symbolic message
      std::string s2 = s;
      return iltrim(s2);
    }

    /// Trim from end
    inline std::string rtrim(const std::string& s) { //< @note Could just pass by value, but const& sends a symbolic message
      std::string s2 = s;
      return irtrim(s2);
    }

    /// Trim from both ends
    inline std::string trim(const std::string& s) { //< @note Could just pass by value, but const& sends a symbolic message
      std::string s2 = s;
      return itrim(s2);
    }


  }


  // Annoyingly, this doesn't work without significant SFINAE etc., due to clashes with existing string & stream operators
  // /// string + any appending operator for convenience in the YODA namespace
  // template <typename T>
  // std::string& operator + (std::string& s, const T& x) {
  //   s += Utils::toStr(x);
  //   return s;
  // }
  // template <typename T>
  // std::string operator + (const T& x, std::string& s) {
  //   return Utils::toStr(x) + s;
  // }
  // template <typename T>
  // std::string operator + (const char* s, const T& x) {
  //   return s + Utils::toStr(x);
  // }
  // template <typename T>
  // std::string operator + (const T& x, const char* s) {
  //   return Utils::toStr(x) + x;
  // }


}

#endif