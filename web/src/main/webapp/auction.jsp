<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    long currentTimeMillis = System.currentTimeMillis();
    long auctionEndMillis = currentTimeMillis + (200 * 60 * 1000);
%>


<html>
<head>
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin=""/>
    <link
            rel="stylesheet"
            as="style"
            onload="this.rel='stylesheet'"
            href="https://fonts.googleapis.com/css2?display=swap&amp;family=Noto+Sans%3Awght%40400%3B500%3B700%3B900&amp;family=Plus+Jakarta+Sans%3Awght%40400%3B500%3B700%3B800"
    />

    <title>BidSpere | Auction Page</title>
    <link rel="icon" type="image/x-icon" href="img.png"/>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
</head>
<body>
<div class="relative flex size-full min-h-screen flex-col bg-[#fcf8f8] group/design-root overflow-x-hidden"
     style='font-family: "Plus Jakarta Sans", "Noto Sans", sans-serif;'>
    <div class="layout-container flex h-full grow flex-col">
        <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-b-[#f3e7e8] px-10 py-3">
            <div class="flex items-center gap-8">
                <div class="flex items-center gap-4 text-[#1b0e0e]">
                    <div class="size-14">
                        <img src="img.png" alt="BidSphere Logo" class="w-full h-full object-contain">
                    </div>
                    <h2 class="text-[#1b0e0e] text-lg font-bold leading-tight tracking-[-0.015em]">BidSphere</h2>
                </div>
                <div class="flex items-center gap-9">
                    <a class="text-[#1b0e0e] text-sm font-medium leading-normal" href="#">Home</a>
                    <a class="text-[#1b0e0e] text-sm font-medium leading-normal" href="#">Categories</a>
                    <a class="text-[#1b0e0e] text-sm font-medium leading-normal" href="#">My Bids</a>
                    <a class="text-[#1b0e0e] text-sm font-medium leading-normal" href="#">Watchlist</a>
                </div>
            </div>
            <div class="flex flex-1 justify-end gap-8">
                <label class="flex flex-col min-w-40 !h-10 max-w-64">
                    <div class="flex w-full flex-1 items-stretch rounded-xl h-full">
                        <div
                                class="text-[#994d51] flex border-none bg-[#f3e7e8] items-center justify-center pl-4 rounded-l-xl border-r-0"
                                data-icon="MagnifyingGlass"
                                data-size="24px"
                                data-weight="regular"
                        >
                            <svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" fill="currentColor"
                                 viewBox="0 0 256 256">
                                <path
                                        d="M229.66,218.34l-50.07-50.06a88.11,88.11,0,1,0-11.31,11.31l50.06,50.07a8,8,0,0,0,11.32-11.32ZM40,112a72,72,0,1,1,72,72A72.08,72.08,0,0,1,40,112Z"
                                ></path>
                            </svg>
                        </div>
                        <input
                                placeholder="Search"
                                class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-[#1b0e0e] focus:outline-0 focus:ring-0 border-none bg-[#f3e7e8] focus:border-none h-full placeholder:text-[#994d51] px-4 rounded-l-none border-l-0 pl-2 text-base font-normal leading-normal"
                                value=""
                        />
                    </div>
                </label>
                <button
                        class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-xl h-10 px-4 bg-[#ea2832] text-[#fcf8f8] text-sm font-bold leading-normal tracking-[0.015em]"
                        onclick="window.location.href='signin.html'"
                >
                    <span class="truncate">Sign In</span>
                </button>
                <button
                        class="flex max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-xl h-10 bg-[#f3e7e8] text-[#1b0e0e] gap-2 text-sm font-bold leading-normal tracking-[0.015em] min-w-0 px-2.5"
                >
                    <div class="text-[#1b0e0e]" data-icon="Bell" data-size="20px" data-weight="regular">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" fill="currentColor"
                             viewBox="0 0 256 256">
                            <path
                                    d="M221.8,175.94C216.25,166.38,208,139.33,208,104a80,80,0,1,0-160,0c0,35.34-8.26,62.38-13.81,71.94A16,16,0,0,0,48,200H88.81a40,40,0,0,0,78.38,0H208a16,16,0,0,0,13.8-24.06ZM128,216a24,24,0,0,1-22.62-16h45.24A24,24,0,0,1,128,216ZM48,184c7.7-13.24,16-43.92,16-80a64,64,0,1,1,128,0c0,36.05,8.28,66.73,16,80Z"
                            ></path>
                        </svg>
                    </div>
                </button>
                <div
                        class="bg-center bg-no-repeat aspect-square bg-cover rounded-full size-10"
                        style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAZ0hM_0K7hAxUDA8ZK6jLJSf0xhYBHXd1kxgavEvipVoiaOnDy1JkGvfFAxYK6HPOfYUQtgj6fMste8MMwhmXHgE2GM6D8PFdwKxs_fZkEWzyP75RG73QyyRtwbVueY0DkcoBPCm-xUQmhMprHUfGOY5uKLw_1aVx5w4vXVpP9NKxDIw6LzHDIf394yNH9AKpZmJp5oBfZEe6slYRwV6Yjol6eMCX0LkyN4RcWwsbrfovgRKn5YjqJeLkKlB_KjO-r4LAf_2gf7_o");'
                ></div>
            </div>
        </header>
        <div class="px-40 flex flex-1 justify-center py-5">
            <div class="layout-content-container flex flex-col max-w-[960px] flex-1">
                <div class="flex flex-wrap gap-2 p-4">
                    <a class="text-[#994d51] text-base font-medium leading-normal" href="#">Collectibles</a>
                    <span class="text-[#994d51] text-base font-medium leading-normal">/</span>
                    <span class="text-[#1b0e0e] text-base font-medium leading-normal">Vintage Watches</span>
                </div>
                <div class="flex flex-wrap justify-between gap-3 p-4">
                    <div class="flex min-w-72 flex-col gap-3">
                        <p class="text-[#1b0e0e] tracking-light text-[32px] font-bold leading-tight">Vintage Chronograph
                            Watch</p>
                        <p class="text-[#994d51] text-sm font-normal leading-normal">
                            A rare and highly sought-after vintage chronograph watch from the 1960s. This timepiece
                            features a stainless steel case, a black dial with luminous markers, and a
                            manual-winding movement. It's in excellent condition and comes with its original box and
                            papers.
                        </p>
                    </div>
                </div>
                <div class="flex w-full grow bg-[#fcf8f8] @container p-4">
                    <div class="w-full gap-1 overflow-hidden bg-[#fcf8f8] @[480px]:gap-2 aspect-[3/2] rounded-xl grid grid-cols-[2fr_1fr_1fr]">
                        <div
                                class="w-full bg-center bg-no-repeat bg-cover aspect-auto rounded-none row-span-2"
                                style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDhloSSlDOfniErA63BmN1Uo90XGpjg3ugO-NNhHygXQq1CQFPqGA1C1bC9dCJ8eoYkZ-PRUNXby6gvJUxM9Zsml3TQUVzcJ6ioAXpCODvCXbMHANnL05mKRgNa5igIa5LP-MWdRb6G2kGAQImY4vP5TOOYj0ozLD-ls9iOvdmONdp6Iw7yb6yYjohjRKykfoTVQWCgjGxU1X0wzoklBHggRUkBqq6z0zxpxq8r68AxbaYqG9o-5lS4EtlTnNWwAjOZMO3LQVoqMzE");'
                        ></div>
                        <div
                                class="w-full bg-center bg-no-repeat bg-cover aspect-auto rounded-none col-span-2"
                                style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCzezXzDEQsj6Pb2hZS1fEXY5EfAYod0pWpvfpdiNRYTORCDG-ZkLyR-vsL6nvBZSwhnSig_O7dyHpqO0ZF1D5cwQenzvwr8J3pNNJOS9DFUxx6txW2eUlVDMYSdSOGCy1jo3aUklu9q6cUdNaW5LlwzNWit8wzMW_yokJC1GykK8lgC57ABHvU5Xs7S0TXen1ntI3L3Z5tWKWwgQLEDpGsDTpaQ5XEW08N8tyhE_J083nknusSQS-kCqIyONZnpzjC8hv9ERf5T40");'
                        ></div>
                        <div
                                class="w-full bg-center bg-no-repeat bg-cover aspect-auto rounded-none col-span-2"
                                style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuClZc8S-SZMUvHewHUI1BOrF7Mzqgak_ZVuRvTfFDQ8aT1JV37AoCwdsNn8KLEY2RksSe5NB7cR58fICHNYkFgUWJwOfrPJTtIr2nVKr69ldgiXDCXqxrwTyUFqrlNYoPqxgw_vje4mjBF_tdgs5mLiwmcDwn1EjNXYR333X9zXnv9K3-KN1lzpkoA-yS0r_UieIbzwvO9AwTOk3VbvfoXJQl9lcb-EtVzrYIhjwbnSHYr-QUU0GBPgJ98gAsRnPuA8VCxsqy6x_i0");'
                        ></div>
                    </div>
                </div>
                <h2 class="text-[#1b0e0e] text-[22px] font-bold leading-tight tracking-[-0.015em] px-4 pb-3 pt-5">
                    Auction Details</h2>
                <div class="p-4 grid grid-cols-[20%_1fr] gap-x-6">
                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Started Price</p>
                        <p class="text-[#1b0e0e] text-sm font-normal leading-normal">Rs. 500,000 .00</p>
                    </div>

                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-semibold leading-normal">Auction Status</p>
                        <p class="text-[#1b0e0e] text-sm font-bold leading-normal">Current Highest Bid:
                            ${highestBid}</p>
                    </div>

                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Time Remaining</p>
                        <p id="countdown" class="text-[#1b0e0e] text-sm font-bold leading-normal text-red-600">
                            Loading…</p>
                    </div>

                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Bids</p>
                        <p class="text-[#1b0e0e] text-sm font-normal leading-normal">12</p>
                    </div>
                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Seller</p>
                        <p class="text-[#1b0e0e] text-sm font-normal leading-normal">Mahinda Rajapakse</p>
                    </div>
                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Condition</p>
                        <p class="text-[#1b0e0e] text-sm font-normal leading-normal">Excellent</p>
                    </div>
                    <div class="col-span-2 grid grid-cols-subgrid border-t border-t-[#e7d0d1] py-5">
                        <p class="text-[#994d51] text-sm font-normal leading-normal">Shipping</p>
                        <p class="text-[#1b0e0e] text-sm font-normal leading-normal">Free</p>
                    </div>
                </div>


                <div class="px-4 py-3 @container">
                    <div class="flex overflow-hidden rounded-xl border border-[#e7d0d1] bg-[#fcf8f8]">

                    </div>


                    <style>
                        @container(max-width:120px) {
                            .table-bda8068e-2d05-4217-9d26-06738e6bc232-column-120 {
                                display: none;
                            }
                        }

                        @container(max-width:240px) {
                            .table-bda8068e-2d05-4217-9d26-06738e6bc232-column-240 {
                                display: none;
                            }
                        }

                        @container(max-width:360px) {
                            .table-bda8068e-2d05-4217-9d26-06738e6bc232-column-360 {
                                display: none;
                            }
                        }
                    </style>
                </div>


                <form action="bid" method="post">

                    <div class="flex max-w-[480px] flex-wrap items-end gap-4 px-4 py-3">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-[#1b0e0e] text-base font-medium leading-normal pb-2">Your Bid</p>
                            <input
                                    placeholder="Enter your bid"
                                    class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-[#1b0e0e] focus:outline-0 focus:ring-0 border border-[#e7d0d1] bg-[#fcf8f8] focus:border-[#e7d0d1] h-14 placeholder:text-[#994d51] p-[15px] text-base font-normal leading-normal"
                                    value=""
                                    name="bid"
                                    id="bidInput"
                                    type="number"

                            />
                        </label>

                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-[#1b0e0e] text-base font-medium leading-normal pb-2">Max Bid Amount</p>
                            <input
                                    placeholder="Rs. 500,000 .00"
<%--                                    class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-[#1b0e0e] focus:outline-0 focus:ring-0 border border-[#e7d0d1] bg-[#fcf8f8] focus:border-[#e7d0d1] h-14 placeholder:text-[#994d51] p-[15px] text-base font-normal leading-normal"--%>
                                    value=""
                                    name="max-bid"
                                    type="number"

                            />
                        </label>
                    </div>

                    <div class="flex px-4 py-3 justify-end">
                        <button
                                class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-xl h-10 px-4 bg-[#ea2832] text-[#fcf8f8] text-sm font-bold leading-normal tracking-[0.015em]"
                                id="placeBidBtn"
                                type="submit"

                        >
                            <span class="truncate">Place Bid</span>
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<script>
    // Get auction end time from server
    const auctionEndTime = <%= auctionEndMillis %>;

    const countdownEl = document.getElementById('countdown');
    const placeBidBtn = document.getElementById('placeBidBtn');
    const bidInput = document.getElementById('bidInput');

    let timer;

    function updateCountdown() {
        const now = Date.now();
        let distance = auctionEndTime - now;

        if (distance <= 0) {
            countdownEl.textContent = 'Auction Ended';
            countdownEl.className = 'text-[#1b0e0e] text-sm font-bold leading-normal text-red-600';

            // Disable bidding when auction ends
            placeBidBtn.disabled = true;
            placeBidBtn.className = 'flex min-w-[84px] max-w-[480px] cursor-not-allowed items-center justify-center overflow-hidden rounded-xl h-10 px-4 bg-gray-400 text-[#fcf8f8] text-sm font-bold leading-normal tracking-[0.015em]';
            placeBidBtn.innerHTML = '<span class="truncate">Auction Ended</span>';

            bidInput.disabled = true;
            bidInput.className = 'form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-gray-400 focus:outline-0 focus:ring-0 border border-[#e7d0d1] bg-gray-100 focus:border-[#e7d0d1] h-14 placeholder:text-[#994d51] p-[15px] text-base font-normal leading-normal cursor-not-allowed';

            clearInterval(timer);
            return;
        }

        const days = Math.floor(distance / 86400000);     // 1000*60*60*24
        distance %= 86400000;
        const hours = Math.floor(distance / 3600000);     // 1000*60*60
        distance %= 3600000;
        const minutes = Math.floor(distance / 60000);     // 1000*60
        const seconds = Math.floor((distance % 60000) / 1000);

        let timeString = '';
        if (days > 0) {
            timeString += days + 'd ';
        }
        if (hours > 0 || days > 0) {
            timeString += hours + 'h ';
        }
        timeString += minutes + 'm ' + seconds + 's';

        countdownEl.textContent = timeString;

        // Change color as time gets closer to end
        if (distance < 300000) { // Less than 5 minutes
            countdownEl.className = 'text-[#1b0e0e] text-sm font-bold leading-normal text-red-600 animate-pulse';
        } else if (distance < 600000) { // Less than 10 minutes
            countdownEl.className = 'text-[#1b0e0e] text-sm font-bold leading-normal text-orange-600';
        } else {
            countdownEl.className = 'text-[#1b0e0e] text-sm font-bold leading-normal text-green-600';
        }
    }

    // Start the countdown
    updateCountdown(); // Initial call
    timer = setInterval(updateCountdown, 1000); // Update every second

    // Add some interactivity to the bid form
    document.querySelector('form').addEventListener('submit', function (e) {
        const now = Date.now();
        if (now >= auctionEndTime) {
            e.preventDefault();
            alert('Auction has ended. You can no longer place bids.');
            return;
        }

        const bidValue = bidInput.value;

        if (!bidValue || parseFloat(bidValue) < minBid) {
            e.preventDefault();
            alert('Please enter a valid bid amount (minimum Rs. ' + minBid.toLocaleString() + ')');
            return;
        }

    });
</script>


</body>
</html>
















