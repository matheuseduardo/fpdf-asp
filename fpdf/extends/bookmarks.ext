this.outlines=lib.newArray();
this.OutlineRoot;

this.Bookmark=function Bookmark(xtxt , xlevel , xy)
	{
	if (arguments.length<2) {xlevel=0};
	if (arguments.length<3) {xy=-1};
	
	if(xy==-1)xy=this.GetY();
	 this.outlines[lib.count(this.outlines)]=lib.newArray("t" , xtxt,"l" , xlevel,"y" , xy,"p" , this.PageNo());
	}

this._putbookmarks=function _putbookmarks()
	{
	xnb=lib.count(this.outlines);
	if(xnb==0)return;
	xlru=new Array();
	xlevel=0;
	for(xi in this.outlines)
		{
		xo = this.outlines[xi]
		if(xo["l"]>0)
			{
			xparent=xlru[xo["l"]-1];
			 this.outlines[xi]["parent"]=xparent;
			 this.outlines[xparent]["last"]=xi;
			if(xo["l"]>xlevel)
				{
				 this.outlines[xparent]["first"]=xi;
				}
			}
		else {this.outlines[xi]["parent"]=xnb;}
		if(xo["l"]<=xlevel && xi>0)
			{
			xprev=xlru[xo["l"]];
			 this.outlines[xprev]["next"]=xi;
			 this.outlines[xi]["prev"]=xprev;
			}
		xlru[xo["l"]]=xi;
		xlevel=xo["l"];
		}
	xn=this.n+1;
	for(xi in this.outlines)
		{
		 xo = this.outlines[xi]
		 this._newobj();
		 this._out("<</Title " + this._textstring(xo["t"]));
		 this._out("/Parent " + (xn+parseFloat(xo["parent"])) + " 0 R");
		 if(xo["prev"])this._out("/Prev " + (xn+parseFloat(xo["prev"])) + " 0 R");
		 if(xo["next"])this._out("/Next " + (xn+parseFloat(xo["next"])) + " 0 R");
		 if(xo["first"])this._out("/First " + (xn+parseFloat(xo["first"])) + " 0 R");
		 if(xo["last"])this._out("/Last " + (xn+parseFloat(xo["last"])) + " 0 R");
		 this._out(lib.sprintf("/Dest [%d 0 R /XYZ 0 %.2f null]",1+2*parseFloat(xo["p"]),(this.h-parseFloat(xo["y"]))*this.k));
		 this._out("/Count 0>>");
		 this._out("endobj");
		}
	 this._newobj();
	 this.OutlineRoot=this.n;
	 this._out("<</Type /Outlines /First " + xn + " 0 R");
	 this._out("/Last " + (xn+xlru[0]) + " 0 R>>");
	 this._out("endobj");
	}

code=function tempfunc(){
	this._putbookmarks();
	}
	
this.ExtendsCode("_putresources",code);

code=function tempfunc(){
	if(lib.count(this.outlines)>0)
		{
		 this._out("/Outlines " + this.OutlineRoot + " 0 R");
		 this._out("/PageMode /UseOutlines");
		}
}

this.ExtendsCode("_putcatalog",code);
