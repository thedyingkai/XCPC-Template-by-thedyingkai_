#pragma once
#include <bits/stdc++.h>
namespace interactive {

struct InteractiveIO {
    long long limit, used = 0;
    std::istream &in;
    std::ostream &out;

    explicit InteractiveIO(long long limit,
                           std::istream &in = std::cin,
                           std::ostream &out = std::cout)
        : limit(limit), in(in), out(out) {}

    // write(out) 输出一条命令，不含末尾换行。
    // read(in) 可读取标量，也可读取整组数据。
    template<class Write, class Read, class Bad>
    auto ask_with(Write write, Read read, Bad bad) {
        if (used >= limit) std::exit(0);
        ++used;
        write(out);
        out << '\n' << std::flush;
        auto reply = read(in);
        if (!in || bad(reply)) std::exit(0);
        return reply;
    }

    template<class Reply, class Write, class Bad>
    Reply ask(Write write, Bad bad) {
        return ask_with(write, [](std::istream &is) {
            Reply value{};
            is >> value;
            return value;
        }, bad);
    }

    template<class Reply, class Write>
    Reply ask(Write write) {
        return ask<Reply>(write, [](const Reply &) { return false; });
    }

    // ACK 是否存在由调用者决定；作答不计入询问预算。
    template<class Write>
    void send_answer(Write write) {
        write(out);
        out << '\n' << std::flush;
    }
};

} // namespace interactive
