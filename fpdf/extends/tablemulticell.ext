var widths;
this.SetWidths=function SetWidths(xw)
	{
	 this.widths=xw;
	}
this.Row=function Row(xdata)
	{
	var xi;var xh;var xnb;
	xnb=0;
	for(xi=0;xi<lib.count(xdata);xi++){xnb=Math.max(xnb,this.NbLines(this.widths[xi],xdata[xi]))};
	
	xh=(xnb)*5;
	this.CheckPageBreak(xh);
	for(xi=0;xi<xdata.length;xi++)
		{
		xw=this.widths[xi];
		xx=this.GetX();
		xy=this.GetY();
		this.SetLineStyle(3);
		this.Rect(xx,xy,xw,xh);
		this.MultiCell(xw,5,xdata[xi],0,"T");
		this.SetXY(xx+xw,xy);
		}
	 this.Ln(xh);
	}
this.CheckPageBreak=function CheckPageBreak(xh)
	{
	if(this.GetY()+xh>this.PageBreakTrigger)this.AddPage(this.CurOrientation);
	}
this.NbLines=function NbLines(xw , xtxt)
	{
	var xnb;
	xcw=this.CurrentFont["cw"];
	if(xw==0)xw=this.w-(this.rMargin)-this.x;
	xwmax=((xw)-2*(this.cMargin))*1000/(this.FontSize);
	xs=lib.str_replace("\r","",xtxt);
	xnb=xs.length;
	if(xnb>0 && xs.charAt(xnb-1)=="\n")xnb--;
	xsep=-1;
	xi=0;
	xj=0;
	xl=0;
	xnl=1;
	while(xi<xnb)
		{
		xc=xs.charAt(xi);
		if(xc=="\n")
			{
			xi++;
			xsep=-1;
			xj=xi;
			xl=0;
			xnl++;
			continue;
			}
		if(xc==" ")xsep=xi;
		xl+=(xcw[xc]);
		if(xl>xwmax)
			{
			if(xsep==-1)
				{
				if(xi==xj)xi++;
				}
			else xi=xsep+1;
			xsep=-1;
			xj=xi;
			xl=0;
			xnl++;
			}
		else {xi++;}
		}
	return xnl;
	}
