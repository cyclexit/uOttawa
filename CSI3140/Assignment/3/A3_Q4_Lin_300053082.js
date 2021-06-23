const MAX_SIZE = 1000;
function sieve() {
    var is_prime = new Array(MAX_SIZE).fill(1);
    is_prime[0] = is_prime[1] = 0;
    for (var i = 2; i < MAX_SIZE; ++i) {
        if (is_prime[i] === 1) {
            var mul = 2;
            while ((i * mul) < MAX_SIZE) {
                is_prime[i * mul] = 0;
                ++mul;
            }
        }
    }
    var primes = ""
    for (var i = 2; i < MAX_SIZE; ++i) {
        if (is_prime[i] === 1) {
            primes += i.toString() + " ";
        }
    }
    console.log(primes); // test
    var p = document.getElementById("primes-print");
    p.innerText = primes;
}

window.onload = sieve();