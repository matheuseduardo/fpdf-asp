this.RoundedRect=function RoundedRect(xx , xy , xw , xh , xr , xstyle , xangle)
	{
	if (arguments.length<6) {xstyle=""};
	if (arguments.length<7) {xangle="1234"};
	
	xk=this.k;
	xhp=this.h;
	if(xstyle=="F")xop="f";
	else if(xstyle=="FD" || xstyle=="DF")xop="B";
	else 
		xop="S";
	xMyArc=4/3*(Math.sqrt(2)-1);
	this._out(lib.sprintf("%.2f %.2f m",(xx+xr)*xk,(xhp-xy)*xk));
	xxc=xx+xw-xr;
	xyc=xy+xr;
	this._out(lib.sprintf("%.2f %.2f l",xxc*xk,(xhp-xy)*xk));
	if(lib.strpos(xangle,"2")===false){this._out(lib.sprintf("%.2f %.2f l",(xx+xw)*xk,(xhp-xy)*xk))};
	else {
		this._Arc(xxc+xr*xMyArc,xyc-xr,xxc+xr,xyc-xr*xMyArc,xxc+xr,xyc);
	}
	xxc=xx+xw-xr;
	xyc=xy+xh-xr;
	this._out(lib.sprintf("%.2f %.2f l",(xx+xw)*xk,(xhp-xyc)*xk));
	if(lib.strpos(xangle,"3")===false)this._out(lib.sprintf("%.2f %.2f l",(xx+xw)*xk,(xhp-(xy+xh))*xk));
	else {
		this._Arc(xxc+xr,xyc+xr*xMyArc,xxc+xr*xMyArc,xyc+xr,xxc,xyc+xr);
	}
	xxc=xx+xr;
	xyc=xy+xh-xr;
	 this._out(lib.sprintf("%.2f %.2f l",xxc*xk,(xhp-(xy+xh))*xk));
	if(lib.strpos(xangle,"4")===false)this._out(lib.sprintf("%.2f %.2f l",(xx)*xk,(xhp-(xy+xh))*xk));
	else 
		this._Arc(xxc-xr*xMyArc,xyc+xr,xxc-xr,xyc+xr*xMyArc,xxc-xr,xyc);
	xxc=xx+xr;
	xyc=xy+xr;
	this._out(lib.sprintf("%.2f %.2f l",(xx)*xk,(xhp-xyc)*xk));
	if(lib.strpos(xangle,"1")===false)
		{
		 this._out(lib.sprintf("%.2f %.2f l",(xx)*xk,(xhp-xy)*xk));
		 this._out(lib.sprintf("%.2f %.2f l",(xx+xw)*xk,(xhp-xy)*xk));
		}
	else 
		this._Arc(xxc-xr,xyc-xr*xMyArc,xxc-xr*xMyArc,xyc-xr,xxc,xyc-xr);
	this._out(xop);
	}
this._Arc=function _Arc(xx1 , xy1 , xx2 , xy2 , xx3 , xy3)
	{
	xh=this.h;
	(xx1);
	 this._out(lib.sprintf("%.2f %.2f %.2f %.2f %.2f %.2f c ",xx1*this.k,(xh-xy1)*this.k,xx2*this.k,(xh-xy2)*this.k,xx3*this.k,(xh-xy3)*this.k));
	}
