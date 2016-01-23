/* 
 * File:   Parser.cpp
 * Author: Charlie Brown
 * 
 * Created on 23 janvier 2016, 18:56
 */

#include "Parser.hpp"

Parser::Parser() {
}

Parser::Parser(const Parser& orig) {
}

Parser::~Parser() {
}

void Parser::SetPa(vector<vector<int> > pa) {
    this->pa = pa;
}

vector<vector<int> > Parser::GetPa() const {
    return pa;
}

void Parser::SetPm(vector<vector<int> > pm) {
    this->pm = pm;
}

vector<vector<int> > Parser::GetPm() const {
    return pm;
}

void Parser::SetPd(vector<vector<int> > pd) {
    this->pd = pd;
}

vector<vector<int> > Parser::GetPd() const {
    return pd;
}

void Parser::SetD(vector<vector<int> > d) {
    this->d = d;
}

vector<vector<int> > Parser::GetD() const {
    return d;
}

void Parser::SetZ(vector<vector<int> > z) {
    this->z = z;
}

vector<vector<int> > Parser::GetZ() const {
    return z;
}

