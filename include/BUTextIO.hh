#ifndef __BU_TEXT_IO_HH__
#define __BU_TEXT_IO_HH__

#include "BUTextController.hh"

class BUTextIO {
public:
    BUTextIO();
    void AddOutputStream(Level::level level, std::ostream *os);
    void ResetStreams(Level::level level);
    void Print(Level::level, const char *fmt, ...);
private:
    std::vector<BUTextController> controllers;
};

#endif