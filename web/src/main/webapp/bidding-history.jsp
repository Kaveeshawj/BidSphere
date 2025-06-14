<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="model.BidEntry" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BidSpere | Bidding History</title>
    <link rel="icon" type="image/x-icon" href="img.png"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'custom-brown': '#1b0e0e',
                        'custom-rose': '#994d51',
                        'custom-light': '#fcf8f8',
                        'custom-border': '#e7d0d1'
                    }
                }
            }
        }
    </script>

    <style>
        /* Back to Auction Button Styling */
        .back-to-auction-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            margin: 24px;
            background: linear-gradient(135deg, #994d51 0%, #7a3a3d 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(153, 77, 81, 0.2);
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .back-to-auction-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .back-to-auction-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(153, 77, 81, 0.3);
            background: linear-gradient(135deg, #7a3a3d 0%, #662f32 100%);
            text-decoration: none;
            color: white;
        }

        .back-to-auction-btn:hover:before {
            left: 100%;
        }

        .back-to-auction-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(153, 77, 81, 0.2);
        }

        /* Back arrow icon */
        .back-icon {
            width: 16px;
            height: 16px;
            fill: currentColor;
            flex-shrink: 0;
        }

        /* Alternative minimal style using your theme colors */
        .back-to-auction-minimal {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            margin: 24px;
            background: #fcf8f8;
            color: #994d51;
            text-decoration: none;
            border: 2px solid #994d51;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .back-to-auction-minimal:hover {
            background: #994d51;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            text-decoration: none;
        }

        /* Dark theme alternative */
        .back-to-auction-dark {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 28px;
            margin: 24px;
            background: #1b0e0e;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(27, 14, 14, 0.3);
            border: 1px solid #994d51;
        }

        .back-to-auction-dark:hover {
            background: #2d1a1a;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(27, 14, 14, 0.4);
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body class="bg-gray-50">
<%
    List<BidEntry> bidHistory = (List<BidEntry>) request.getAttribute("bidHistory");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<a href="AuctionServlet" class="back-to-auction-btn"> <svg class="back-icon" viewBox="0 0 24 24"> <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/> </svg> Back to Auction </a>

<h2 class="text-[#1b0e0e] text-[20px] font-semibold px-6 pt-6 pb-3">Bidding History</h2>

<!-- Error Alert -->
<% if (errorMessage != null) { %>
<div class="mx-6 mb-4">
    <div id="errorAlert" class="bg-red-50 border-l-4 border-red-400 p-4 rounded-lg shadow-sm">
        <div class="flex items-center">
            <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd"
                          d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                          clip-rule="evenodd"/>
                </svg>
            </div>
            <div class="ml-3 flex-1">
                <p class="text-sm text-red-700 font-medium">
                    <%= errorMessage %>
                </p>
            </div>
            <div class="ml-auto pl-3">
                <button onclick="closeAlert()" class="inline-flex text-red-400 hover:text-red-600 focus:outline-none">
                    <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"/>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>
<% } %>

<!-- Success Alert (for when bid is successful) -->
<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
%>
<div class="mx-6 mb-4">
    <div id="successAlert" class="bg-green-50 border-l-4 border-green-400 p-4 rounded-lg shadow-sm">
        <div class="flex items-center">
            <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-green-400" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd"
                          d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                          clip-rule="evenodd"/>
                </svg>
            </div>
            <div class="ml-3 flex-1">
                <p class="text-sm text-green-700 font-medium">
                    Bid placed successfully! 🎉
                </p>
            </div>
            <div class="ml-auto pl-3">
                <button onclick="closeSuccessAlert()"
                        class="inline-flex text-green-400 hover:text-green-600 focus:outline-none">
                    <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"/>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>
<% } %>

<div class="px-6 pb-6">
    <div class="overflow-hidden rounded-xl border border-[#e7d0d1] bg-[#fcf8f8]">


        <div id="bid-history-container">
            Loading bids...
        </div>


    </div>
</div>

<script>
    // Clean URL parameters immediately after page load
    window.addEventListener('load', function () {
        // Check if there are any alert parameters in URL
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success') || urlParams.has('error')) {
            // Remove parameters from URL without page reload
            const cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
            window.history.replaceState({}, document.title, cleanUrl);
        }
    });

    // Auto-hide alerts after 5 seconds
    setTimeout(function () {
        const errorAlert = document.getElementById('errorAlert');
        const successAlert = document.getElementById('successAlert');

        if (errorAlert) {
            errorAlert.style.opacity = '0';
            errorAlert.style.transition = 'opacity 0.5s';
            setTimeout(() => errorAlert.remove(), 500);
        }

        if (successAlert) {
            successAlert.style.opacity = '0';
            successAlert.style.transition = 'opacity 0.5s';
            setTimeout(() => successAlert.remove(), 500);
        }
    }, 5000);

    // Manual close functions
    function closeAlert() {
        const alert = document.getElementById('errorAlert');
        alert.style.opacity = '0';
        alert.style.transition = 'opacity 0.3s';
        setTimeout(() => alert.remove(), 300);
    }

    function closeSuccessAlert() {
        const alert = document.getElementById('successAlert');
        alert.style.opacity = '0';
        alert.style.transition = 'opacity 0.3s';
        setTimeout(() => alert.remove(), 300);
    }

    // Updated JavaScript section for your bidding history page
    function refreshBidTable() {
        fetch('<%= request.getContextPath() %>/bidding-history?ajax=true', {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'Cache-Control': 'no-cache'
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(html => {
                const container = document.getElementById('bid-history-container');
                if (container) {
                    container.innerHTML = html;
                    console.log('Bid table refreshed at:', new Date().toLocaleTimeString());
                }
            })
            .catch(error => {
                console.error("Failed to refresh bids:", error);
                // Show user-friendly error message
                const container = document.getElementById('bid-history-container');
                if (container) {
                    container.innerHTML = `
                <div class="text-center px-6 py-8 text-red-500">
                    <p>Failed to load latest bids. Retrying...</p>
                </div>
            `;
                }
            });
    }

    // Initialize and set up auto-refresh
    document.addEventListener('DOMContentLoaded', function () {
        // Initial load
        refreshBidTable();

        // Set up periodic refresh every 3 seconds
        const refreshInterval = setInterval(refreshBidTable, 3000);

        // Clean up interval when page is about to unload
        window.addEventListener('beforeunload', function () {
            clearInterval(refreshInterval);
        });

        // Pause refresh when tab is not visible (optional optimization)
        document.addEventListener('visibilitychange', function () {
            if (document.hidden) {
                clearInterval(refreshInterval);
            } else {
                // Resume refresh when tab becomes visible again
                refreshBidTable();
                setInterval(refreshBidTable, 3000);
            }
        });
    });
</script>

</body>
</html>