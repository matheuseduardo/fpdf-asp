this.Sector=function Sector(xxc , xyc , xr , xa , xb , xstyle , xcw , xo)
	{
	if (arguments.length<6) {xstyle="FD"};
	if (arguments.length<7) {xcw=true};
	if (arguments.length<8) {xo=90};
	
	if(xcw)
		{
		xd=xb;
		xb=xo-xa;
		xa=xo-xd;
		}
	else 

		{
		xb+=xo;
		xa+=xo;
		}
	xa=(xa%360)+360;
	xb=(xb%360)+360;
	if(xa>xb)xb+=360;
	xb=xb/360*2*Math.PI;
	xa=xa/360*2*Math.PI;
	xd=xb-xa;
	if(xd==0)xd=2*Math.PI;
	xk=this.k;
	xhp=this.h;
	if(xstyle=="F")xop="f";
	else if(xstyle=="FD" || xstyle=="DF")xop="b";
	else {xop="s";}
	if(Math.sin(xd/2))xMyArc=4/3*(1-Math.cos(xd/2))/Math.sin(xd/2)*xr;
	 this._out(lib.sprintf("%.2f %.2f m",(xxc)*xk,(xhp-xyc)*xk));
	 this._out(lib.sprintf("%.2f %.2f l",(xxc+xr*Math.cos(xa))*xk,((xhp-(xyc-xr*Math.sin(xa)))*xk)));
	if(xd<Math.PI/2)
		{
		 this._Arc(xxc+xr*Math.cos(xa)+xMyArc*Math.cos(Math.PI/2+xa),xyc-xr*Math.sin(xa)-xMyArc*Math.sin(Math.PI/2+xa),xxc+xr*Math.cos(xb)+xMyArc*Math.cos(xb-Math.PI/2),xyc-xr*Math.sin(xb)-xMyArc*Math.sin(xb-Math.PI/2),xxc+xr*Math.cos(xb),xyc-xr*Math.sin(xb));
		}
	else 
		{
		xb=xa+xd/4;
		xMyArc=4/3*(1-Math.cos(xd/8))/Math.sin(xd/8)*xr;
		 this._Arc(xxc+xr*Math.cos(xa)+xMyArc*Math.cos(Math.PI/2+xa),xyc-xr*Math.sin(xa)-xMyArc*Math.sin(Math.PI/2+xa),xxc+xr*Math.cos(xb)+xMyArc*Math.cos(xb-Math.PI/2),xyc-xr*Math.sin(xb)-xMyArc*Math.sin(xb-Math.PI/2),xxc+xr*Math.cos(xb),xyc-xr*Math.sin(xb));
		xa=xb;
		xb=xa+xd/4;
		 this._Arc(xxc+xr*Math.cos(xa)+xMyArc*Math.cos(Math.PI/2+xa),xyc-xr*Math.sin(xa)-xMyArc*Math.sin(Math.PI/2+xa),xxc+xr*Math.cos(xb)+xMyArc*Math.cos(xb-Math.PI/2),xyc-xr*Math.sin(xb)-xMyArc*Math.sin(xb-Math.PI/2),xxc+xr*Math.cos(xb),xyc-xr*Math.sin(xb));
		xa=xb;
		xb=xa+xd/4;
		 this._Arc(xxc+xr*Math.cos(xa)+xMyArc*Math.cos(Math.PI/2+xa),xyc-xr*Math.sin(xa)-xMyArc*Math.sin(Math.PI/2+xa),xxc+xr*Math.cos(xb)+xMyArc*Math.cos(xb-Math.PI/2),xyc-xr*Math.sin(xb)-xMyArc*Math.sin(xb-Math.PI/2),xxc+xr*Math.cos(xb),xyc-xr*Math.sin(xb));
		xa=xb;
		xb=xa+xd/4;
		 this._Arc(xxc+xr*Math.cos(xa)+xMyArc*Math.cos(Math.PI/2+xa),xyc-xr*Math.sin(xa)-xMyArc*Math.sin(Math.PI/2+xa),xxc+xr*Math.cos(xb)+xMyArc*Math.cos(xb-Math.PI/2),xyc-xr*Math.sin(xb)-xMyArc*Math.sin(xb-Math.PI/2),xxc+xr*Math.cos(xb),xyc-xr*Math.sin(xb));
		}
	 this._out(xop);
	}
this._Arc=function _Arc(xx1 , xy1 , xx2 , xy2 , xx3 , xy3)
	{
	xh=this.h;
	 this._out(lib.sprintf("%.2f %.2f %.2f %.2f %.2f %.2f c",xx1*this.k,(xh-xy1)*this.k,xx2*this.k,(xh-xy2)*this.k,xx3*this.k,(xh-xy3)*this.k));
	}

