var calc = new Function('return ' + document.getElementById('calc').value);
document.getElementById('result').innerHTML = calc();
