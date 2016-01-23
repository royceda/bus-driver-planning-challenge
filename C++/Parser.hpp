/* 
 * File:   Parser.hpp
 * Author: Charlie Brown
 *
 * Created on 23 janvier 2016, 18:56
 */

#ifndef PARSER_HPP
#define	PARSER_HPP

#include <vector>

using namespace std;

class Parser {
public:
    Parser();
    Parser(const Parser& orig);
    virtual ~Parser();
    void SetPa(vector<vector<int> > pa);
    vector<vector<int> > GetPa() const;
    void SetPm(vector<vector<int> > pm);
    vector<vector<int> > GetPm() const;
    void SetPd(vector<vector<int> > pd);
    vector<vector<int> > GetPd() const;
    void SetD(vector<vector<int> > d);
    vector<vector<int> > GetD() const;
    void SetZ(vector<vector<int> > z);
    vector<vector<int> > GetZ() const;
private:
    vector <vector <int> > z;
    vector <vector <int> > d;
    vector <vector <int> > pd;
    vector <vector <int> > pm;
    vector <vector <int> > pa;
    

};

#endif	/* PARSER_HPP */

