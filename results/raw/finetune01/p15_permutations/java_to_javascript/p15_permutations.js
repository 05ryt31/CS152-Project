function permute(a) {
    var o = [];
 
    function p(t,a){
        if (a.length==0) o[o.length]=t;
        else for(var n=0;n<a.length;n++)
            p(t+a[n],a.slice(0,n)+a.slice(n+1));
    }
 
    p("",a);
    return o;
}
 
var s = "abc";
for (var i in permute(s)) document.write(permute(s)[i]+"<br>");
