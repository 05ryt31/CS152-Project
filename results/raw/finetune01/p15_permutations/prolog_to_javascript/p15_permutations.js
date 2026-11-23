function permute(a) {
    var o = [];
 
    function p(t,a){
        if (a.length==0) 
            o[o.length]=t;
        else
            for(var i=0;i<a.length;i++)
                p(t.concat(a[i]),a.slice(0,i).concat(a.slice(i+1)));
    }
 
    p([],a);
    return o;
}
 
var s = 'abc';
for (var i in permute(s.split(''))) {
    document.write(permute(s.split(''))[i].join('') + '<br>');
}
