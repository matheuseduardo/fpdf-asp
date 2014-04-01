this.Circle=function Circle(xx , xy , xr , xstyle)
	{
	if (arguments.length<4) {xstyle=""};
	 this.Ellipse(xx,xy,xr,xr,xstyle);
	}
this.Ellipse=function Ellipse(xx , xy , xrx , xry , xstyle)
	{
	if (arguments.length<5) {xstyle="D"};
	if(xstyle=="F")xop="f";
	else if(xstyle=="FD" || xstyle=="DF")xop="B";
	else {xop="S"};
	xlx=4/3* (Math.SQRT2-1) * xrx;
	xly=4/3 * (Math.SQRT2-1) * xry;
	xk=(this.k);
	xh=(this.h);
	 this._out(lib.sprintf("%.2f %.2f m %.2f %.2f %.2f %.2f %.2f %.2f c",(xx+xrx)*xk,(xh-xy)*xk,(xx+xrx)*xk,(xh-(xy-xly))*xk,(xx+xlx)*xk,(xh-(xy-xry))*xk,xx*xk,(xh-(xy-xry))*xk));
	 this._out(lib.sprintf("%.2f %.2f %.2f %.2f %.2f %.2f c",(xx-xlx)*xk,(xh-(xy-xry))*xk,(xx-xrx)*xk,(xh-(xy-xly))*xk,(xx-xrx)*xk,(xh-xy)*xk));
	 this._out(lib.sprintf("%.2f %.2f %.2f %.2f %.2f %.2f c",(xx-xrx)*xk,(xh-(xy+xly))*xk,(xx-xlx)*xk,(xh-(xy+xry))*xk,xx*xk,(xh-(xy+xry))*xk));
	 this._out(lib.sprintf("%.2f %.2f %.2f %.2f %.2f %.2f c %s",(xx+xlx)*xk,(xh-(xy+xry))*xk,(xx+xrx)*xk,(xh-(xy+xly))*xk,(xx+xrx)*xk,(xh-xy)*xk,xop));
	}
