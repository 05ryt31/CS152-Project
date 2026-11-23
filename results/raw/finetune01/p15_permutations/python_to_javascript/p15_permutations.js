function permute(a) {
    var o = [];
 
    function p(t,a){
        if (a.length==0) 
            o[o.length]=t;
        else
            for(var j=0;j<a.length;j++)
                p(t+a[j],a.slice(0,j)+a.slice(j+1));
    }
    p("",a);
    return o;
}
 
var s = "abc";
for (var i=0;i<permute(s).length;i++) document.write(permute(s)[i]+"<br>");
