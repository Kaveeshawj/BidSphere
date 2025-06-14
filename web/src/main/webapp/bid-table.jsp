<%@ page import="model.BidEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/30/2025
  Time: 6:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<BidEntry> bidHistory = (List<BidEntry>) request.getAttribute("bidHistory");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<table class="min-w-full text-sm">
    <thead class="bg-[#fcf8f8] text-[#1b0e0e]">
    <tr>
        <th class="text-left px-6 py-4 font-medium">Bidder</th>
        <th class="text-left px-6 py-4 font-medium">Amount</th>
        <th class="text-left px-6 py-4 font-medium">Time</th>
    </tr>
    </thead>
    <tbody class="divide-y divide-[#e7d0d1] text-[#994d51]">
    <% if (bidHistory != null && !bidHistory.isEmpty()) {
        for (BidEntry bid : bidHistory) {
            String bidder = bid.getBidder();
            int amount = bid.getAmount();
            LocalDateTime bidTime = bid.getTimestamp();
            LocalDateTime now = LocalDateTime.now();
            long hoursAgo = ChronoUnit.HOURS.between(bidTime, now);
            String timeDisplay = hoursAgo < 1 ? ChronoUnit.MINUTES.between(bidTime, now) + " minutes ago" :
                    hoursAgo < 24 ? hoursAgo + " hours ago" :
                            ChronoUnit.DAYS.between(bidTime, now) + " days ago";
    %>
    <tr class="hover:bg-[#f3ebeb] transition duration-200">
        <td class="px-6 py-4 font-medium"><%= bidder %></td>
        <td class="px-6 py-4 text-[#994d51]">Rs. <%= String.format("%,d", amount) %> .00</td>
        <td class="px-6 py-4 text-[#8b5a5d]"><%= timeDisplay %></td>
    </tr>
    <%
        }
    }else {
    %>
    <tr>
        <td colspan="3" class="text-center px-6 py-8 text-[#8b5a5d]">
            <div class="flex flex-col items-center">
                <svg class="w-12 h-12 mb-3 text-[#d4a5a8]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                <p class="text-sm font-medium">No bids yet</p>
                <p class="text-xs mt-1">Be the first to place a bid!</p>
            </div>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
