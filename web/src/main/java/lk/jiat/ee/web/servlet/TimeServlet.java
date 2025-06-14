package lk.jiat.ee.web.servlet;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalDateTime;

@WebServlet("/auction-time")
public class TimeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Set auction end time (fixed for now)
    private static final LocalDateTime endTime = LocalDateTime.now().plusDays(2).plusHours(14);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        LocalDateTime now = LocalDateTime.now();
        Duration remaining = Duration.between(now, endTime);

        long seconds = remaining.getSeconds();
        if (seconds < 0) seconds = 0;

        long days = seconds / 86400;
        long hours = (seconds % 86400) / 3600;
        long minutes = (seconds % 3600) / 60;
        long secs = seconds % 60;

        PrintWriter out = response.getWriter();
        out.print(String.format("{\"days\":%d,\"hours\":%d,\"minutes\":%d,\"seconds\":%d}", days, hours, minutes, secs));
        out.flush();
    }
}
