const changePrice = () => {
  const booking = document.getElementById("booking_days");
  const initialPrice = document.getElementById("total-price").innerText;
  booking.addEventListener("input", (event) => {
    const days = event.target.value;
    const price = document.getElementById("total-price");
    price.innerText = initialPrice * days;
  });
};

export { changePrice };
