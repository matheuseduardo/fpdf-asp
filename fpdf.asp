<!--#include file="fpdf/includes/Basics.asp"-->
<script language="jscript" runat="server">
function FPDF()
	{
	this.Version = "1.02 beta"
	var PATH;
	var lib=new clib()
	var page;
	var n;
	var offsets;
	var buffer;
	var pages;
	var state;
	var compress;
	var DefOrientation;
	var CurOrientation;
	var OrientationChanges;
	var fwPt;
	var fhPt;
	var fw;
	var fh;
	var wPt;
	var hPt;
	var k;
	var w;
	var h;
	var x;
	var y;
	var lMargin;
	var tMargin;
	var rMargin;
	var bMargin;
	var cMargin;
	var hasBinary = false;
	var lasth;
	var LineWidth;
	var CoreFonts;
	var fonts;
	var FontFiles;
	var diffs;
	var images;
	var PageLinks;
	var links;
	var FontFamily;
	var FontStyle;
	var underline;
	var CurrentFont;
	var FontSizePt;
	var FontSize;
	var DrawColor;
	var FillColor;
	var TextColor;
	var ColorFlag;
	var ws;
	var AutoPageBreak;
	var PageBreakTrigger;
	var InFooter;
	var ZoomMode;
	var LayoutMode;
	var title;
	var subject;
	var author;
	var keywords;
	var creator;
	var AliasNbPages;

	this.Interlinea=0;

	this.SetPath=function SetPath(value){
		this.PATH = value
		if (this.PATH.charAt(this.PATH.length-1)!="/"){this.PATH+="/"}
		this.FONTPATH = this.PATH + "fonts/"
		this.EXTENDSPATH = this.PATH + "extends/"
		this.MODELSPATH = this.PATH + "models/"
	}

	this.CreatePDF=function CreatePDF(xorientation , xunit , xformat)
		{
		if (arguments.length<1) {xorientation="P"};
		if (arguments.length<2) {xunit="mm"};
		if (arguments.length<3) {xformat="A4"};
		this.SetPath("./fpdf/")
		this.page=0;
		this.n=2;
		this.AliasNbPages="{nb}"
		this.buffer="";
		this.pages=new Array();
		this.offsets=new Array();
		this.OrientationChanges=new Array();
		this.state=0;
		this.fonts=new Array();
		this.FontFiles=new Array();
		this.diffs=new Array();
		this.images=new Array();
		this.links=new Array();
		this.PageLinks=new Array();
		this.InFooter=false;
		this.title="";
		this.subject="";
		this.author="";
		this.keywords="";
		this.creator="";
		this.FontFamily="";
		this.FontStyle="";
		this.FontSizePt=12;
		this.underline=false;
		this.DrawColor="0 G";
		this.FillColor="0 g";
		this.TextColor="0 g";
		this.ColorFlag=false;
		this.ws=0;
		this.PageLinks=new Array();
		this.CurrentFont=new Array();
		this.CoreFonts=new Array();
		this.CoreFonts["courier"]="Courier";
		this.CoreFonts["courierB"]="Courier-Bold";
		this.CoreFonts["courierI"]="Courier-Oblique";
		this.CoreFonts["courierBI"]="Courier-BoldOblique";
		this.CoreFonts["helvetica"]="Helvetica";
		this.CoreFonts["helveticaB"]="Helvetica-Bold";
		this.CoreFonts["helveticaI"]="Helvetica-Oblique";
		this.CoreFonts["helveticaBI"]="Helvetica-BoldOblique";
		this.CoreFonts["times"]="Times-Roman";
		this.CoreFonts["timesB"]="Times-Bold";
		this.CoreFonts["timesI"]="Times-Italic";
		this.CoreFonts["timesBI"]="Times-BoldItalic";
		this.CoreFonts["symbol"]="Symbol";
		this.CoreFonts["zapfdingbats"]="ZapfDingbats";
		if(xunit=="pt")this.k=1;
		else if(xunit=="mm")this.k=72/25.4;
		else if(xunit=="cm")this.k=72/2.54;
		else if(xunit=="in")this.k=72;
		else
		this.Error("Incorrect unit: " + xunit);
		if(xformat.constructor==String)
			{
			xformat=xformat.toLowerCase();
			if(xformat=="a3")xformat=new Array(841.89,1190.55);
			else if(xformat=="a4")xformat=new Array(595.28,841.89);
			else if(xformat=="a5")xformat=new Array(420.94,595.28);
			else if(xformat=="letter")xformat=new Array(612,792);
			else if(xformat=="legal")xformat=new Array(612,1008);
			else
			this.Error("Unknown page format: " + xformat);
			 this.fwPt=xformat[0];
			 this.fhPt=xformat[1];
			}
		else
			{
			 this.fwPt=xformat[0]*this.k;
			 this.fhPt=xformat[1]*this.k;
			}
		 this.fw=this.fwPt/this.k;
		 this.fh=this.fhPt/this.k;
		xorientation=xorientation.toLowerCase();
		if(xorientation=="p" || xorientation=="portrait")
			{
			 this.DefOrientation="P";
			 this.wPt=this.fwPt;
			 this.hPt=this.fhPt;
			}
		else if(xorientation=="l" || xorientation=="landscape")
			{
			 this.DefOrientation="L";
			 this.wPt=this.fhPt;
			 this.hPt=this.fwPt;
			}
		else this.Error("Incorrect orientation: " + xorientation);
		 this.CurOrientation=this.DefOrientation;
		 this.w=this.wPt/this.k;
		 this.h=this.hPt/this.k;
		xmargin=28.35/this.k;
		 this.SetMargins(xmargin,xmargin);
		 this.cMargin=xmargin/10;
		 this.LineWidth=.567/this.k;
		 this.SetAutoPageBreak(true,xmargin);
		 this.SetDisplayMode("fullwidth");
		 this.SetCompression(true);
		}

	this.SetMargins=function SetMargins(xleft , xtop , xright)
		{
			if (arguments.length<3) {xright=-1};
			this.lMargin=xleft;
			this.tMargin=xtop;
			if(xright==-1)xright=xleft;
			this.rMargin=xright;
		}
		this.SetLeftMargin=function SetLeftMargin(xmargin){this.lMargin=xmargin;if(this.page>0 && this.x<xmargin)this.x=xmargin;}
		this.SetTopMargin=function SetTopMargin(xmargin){this.tMargin=xmargin;}
		this.SetRightMargin=function SetRightMargin(xmargin){this.rMargin=xmargin;}
		this.SetAutoPageBreak=function SetAutoPageBreak(xauto , xmargin)
		{
		if (arguments.length<2) {xmargin=0};

		 this.AutoPageBreak=xauto;
		 this.bMargin=xmargin;
		 this.PageBreakTrigger=this.h-xmargin;
		}
	this.SetDisplayMode=function SetDisplayMode(xzoom , xlayout)
		{
		if (arguments.length<2) {xlayout="continuous"};

		if(xzoom=="fullpage" || xzoom=="fullwidth" || xzoom=="real" || xzoom=="default" || !is_string(xzoom))this.ZoomMode=xzoom;
		else if(xzoom=="zoom")this.ZoomMode=xlayout;
		else
		this.Error("Incorrect zoom display mode: " + xzoom);
		if(xlayout=="single" || xlayout=="continuous" || xlayout=="two" || xlayout=="default")this.LayoutMode=xlayout;
		else if(xzoom!="zoom")this.Error("Incorrect layout display mode: " + xlayout);
		}
	this.SetCompression=function SetCompression(xcompress)
		{
		if(lib.function_exists("gzcompress"))this.compress=xcompress;
		else
			this.compress=false;
		}
	this.AcceptPageBreak=function AcceptPageBreak(){return this.AutoPageBreak;}
	this.Header=function Header(){}
	this.Footer=function Footer(){}
	this.PageNo=function PageNo(){return this.page;}
	this.SetTitle=function SetTitle(xtitle) {this.title=xtitle;}
	this.SetSubject=function SetSubject(xsubject){this.subject=xsubject;}
	this.SetAuthor=function SetAuthor(xauthor){this.author=xauthor;}
	this.SetKeywords=function SetKeywords(xkeywords){this.keywords=xkeywords;}
	this.SetCreator=function SetCreator(xcreator){this.creator=xcreator;}
	this.Error=function Error(xmsg)
		{
		Response.Write("<B>FPDF error: </B>" + xmsg);
		Response.End
		}
	this.Open=function Open(){this._begindoc();}
	this.Close=function Close()
		{
		if(this.page==0)this.AddPage();
		 this.InFooter=true;
		 this.Footer();
		 this.InFooter=false;
		 this._endpage();
		 this._enddoc();
		}
	this.AddPage=function AddPage(xorientation)
		{
		if (arguments.length<1) {xorientation=""};
		xfamily=this.FontFamily;
		xstyle=this.FontStyle + (this.underline?"U":"");
		xsize=this.FontSizePt;
		xlw=this.LineWidth;
		xdc=this.DrawColor;
		xfc=this.FillColor;
		xtc=this.TextColor;
		xcf=this.ColorFlag;
		if(this.page>0)
			{
			 this.InFooter=true;
			 this.Footer();
			 this.InFooter=false;
			 this._endpage();
			}
		 this._beginpage(xorientation);
		 this._out("2 J");
		 this.LineWidth=xlw;
		 this._out(lib.sprintf("%.2f w",xlw*this.k));
		if(xfamily)this.SetFont(xfamily,xstyle,xsize);
		 this.DrawColor=xdc;
		if(xdc!="0 G")this._out(xdc);
		 this.FillColor=xfc;
		if(xfc!="0 g")this._out(xfc);
		 this.TextColor=xtc;
		 this.ColorFlag=xcf;
		 this.Header();
		if(this.LineWidth!=xlw)
			{
			 this.LineWidth=xlw;
			 this._out(lib.sprintf("%.2f w",xlw*this.k));
			}
		if(xfamily)this.SetFont(xfamily,xstyle,xsize);
		if(this.DrawColor!=xdc)
			{
			 this.DrawColor=xdc;
			 this._out(xdc);
			}
		if(this.FillColor!=xfc)
			{
			 this.FillColor=xfc;
			 this._out(xfc);
			}
		 this.TextColor=xtc;
		 this.ColorFlag=xcf;
	}

	this.SetDrawColor=function SetDrawColor(xr , xg , xb)
		{
		if (arguments.length<2) {xg=-1};
		if (arguments.length<3) {xb=-1};

		if((xr==0 && xg==0 && xb==0) || xg==-1)this.DrawColor=lib.sprintf("%.3f G",xr/255);
		else this.DrawColor=lib.sprintf("%.3f %.3f %.3f RG",xr/255,xg/255,xb/255);
		if(this.page>0)this._out(this.DrawColor);
		}

	this.SetFillColor=function SetFillColor(xr , xg , xb)
		{
		if (arguments.length<2) {xg=-1};
		if (arguments.length<3) {xb=-1};
		if((xr==0 && xg==0 && xb==0) || xg==-1)this.FillColor=lib.sprintf("%.3f g",xr/255);
		else {this.FillColor=lib.sprintf("%.3f %.3f %.3f rg",xr/255,xg/255,xb/255)};
		 this.ColorFlag=(this.FillColor!=this.TextColor);
		if(this.page>0)this._out(this.FillColor);
		}

	this.SetTextColor=function SetTextColor(xr , xg , xb)
		{
		if (arguments.length<2) {xg=-1};
		if (arguments.length<3) {xb=-1};
		if((xr==0 && xg==0 && xb==0) || xg==-1)this.TextColor=lib.sprintf("%.3f g",xr/255);
		else this.TextColor=lib.sprintf("%.3f %.3f %.3f rg",xr/255,xg/255,xb/255);
		this.ColorFlag=(this.FillColor!=this.TextColor);
		}

	this.GetStringWidth=function GetStringWidth(xs)
		{
		xcw=this.CurrentFont["cw"];
		xw=0;
		xl=lib.strlen(xs);
		for(xi=0;xi<xl;xi++)xw = xw + (xcw[xs.charAt(xi)]);
		return xw*(this.FontSize)/1000;
		}

	this.SetLineWidth=function SetLineWidth(xwidth)
		{
		 this.LineWidth=xwidth;
		if(this.page>0)this._out(lib.sprintf("%.2f w",xwidth*this.k));
		}

	this.SetLineStyle=function SetLineStyle(xwidth,xcap,xjoin,xdash,xphase){
		if (arguments.length<1){xwidth=1}
		if (arguments.length<2){xcap=''}
		if (arguments.length<3){xjoin=''}
		if (arguments.length<4){xdash=''}
		if (arguments.length<5){xphase=0}
		xstring = "";
		if (xwidth>0){
			xstring+= xwidth + " w";
		}
		xca = lib.newArray("butt",0,"round",1,"square",2);
		if (xca[xcap]){
			xstring+= " "+xca[xcap]+" J";
		}
		xja = lib.newArray("miter",0,"round",1,"bevel",2);
		if (xja[xjoin]){
			xstring+= " "+xja[xjoin]+" j";
		}
		if (lib.is_array(xdash)){
			xstring+= " [";
			for(xlen in xdash){
			xlen=xdash[xlen]
			xstring+=" "+xlen;
			}
			xstring+= " ] "+xphase+' d';
		}
		xstring += "\n"+xstring;
		this._out(xstring)
	}

	this.Line=function Line(xx1 , xy1 , xx2 , xy2)
		{
		 this._out(lib.sprintf("%.2f %.2f m %.2f %.2f l S",xx1*this.k,(this.h-xy1)*this.k,xx2*this.k,(this.h-xy2)*this.k));
		}

	this.Rect=function Rect(xx , xy , xw , xh , xstyle)
		{
		if (arguments.length<5) {xstyle=""};
		if(xstyle=="F")xop="f";
		else if(xstyle=="FD" || xstyle=="DF")xop="B";
		else
		xop="S";
		 this._out(lib.sprintf("%.2f %.2f %.2f %.2f re %s",xx*this.k,(this.h-xy)*this.k,xw*this.k,-xh*this.k,xop));
		}

	this.AddFont=function AddFont(xfamily , xstyle, xfile)
		{
		if (arguments.length<2) {xstyle=""};
		if (arguments.length<3) {xfile=""};
		xfamily=xfamily.toLowerCase();
		if(xfamily=="arial")xfamily="helvetica";
		xstyle=xstyle.toUpperCase();
		if(xstyle=="IB")xstyle="BI";
		if(this.fonts[xfamily + xstyle])this.Error("Font already added: " + xfamily + " " + xstyle);
		if(xfile=="")xfile=lib.str_replace(" ","",xfamily) + xstyle.toLowerCase() + ".js";
		xfile=this.FONTPATH + xfile;
		eval(lib.readtextfile(xfile));
		if(!lib.isset(xname))this.Error("Could not include font definition file");
		xi=lib.count(this.fonts)+1;
		this.fonts[xfamily + xstyle]=lib.newArray("i" , xi,"type" , xtype,"name" , xname,"desc" , xdesc,"up" , xup,"ut" , xut,"cw" , xcw,"enc" , xenc,"file" , xfile);
		if(xdiff)
			{
			xd=0;
			xnb=lib.count(this.diffs);
			for(xi=1;xi<=xnb;xi++)
			if(this.diffs[xi]==xdiff)
				{
				xd=xi;
				break;
				}
				if(xd==0)
					{
					xd=xnb+1;
					this.diffs[xd]=xdiff;
					}
			 this.fonts[xfamily + xstyle]["diff"]=xd;
			}
		if(xfile)
			{
			if(xtype=="TrueType")this.FontFiles[xfile]=lib.newArray("length1" , xoriginalsize);
			else this.FontFiles[xfile]=lib.newArray("length1" , xsize1,"length2" , xsize2);
			}
		}

this.SetFont=function SetFont(xfamily , xstyle , xsize)
		{
		if (arguments.length<2) {xstyle=""};
		if (arguments.length<3) {xsize=0};
		var xfpdf_charwidths=new Array();
		xfamily=xfamily.toLowerCase();
		if(xfamily=="")xfamily=this.FontFamily;
		if(xfamily=="arial")xfamily="helvetica";
		else if(xfamily=="symbol" || xfamily=="zapfdingbats")xstyle="";

		xstyle=xstyle.toUpperCase();
		if(lib.is_int(lib.strpos(xstyle,"U")))
			{
			this.underline=true;
			xstyle=lib.str_replace("U","",xstyle);
			}
		else this.underline=false;

		if(xstyle=="IB")xstyle="BI";
		if(xsize==0)xsize=this.FontSizePt;
		if(this.FontFamily==xfamily && this.FontStyle==xstyle && this.FontSizePt==xsize)return;
		xfontkey=xfamily + xstyle;
		if(!this.fonts[xfontkey])
			{
			if(this.CoreFonts[xfontkey])
				{
				if(!xfpdf_charwidths[xfontkey])
					{
					xfile=xfamily;
					if(xfamily=="times" || xfamily=="helvetica")xfile+=xstyle.toLowerCase();
					xfile=this.FONTPATH + xfile +".js";
					eval(lib.readtextfile(xfile));
					if(!lib.isset(xfpdf_charwidths[xfontkey]))this.Error("Could not include font metric file");
					}
				xi=lib.count(this.fonts)+1;
				 this.fonts[xfontkey]=lib.newArray("i" , xi,"type" , "core","name" , this.CoreFonts[xfontkey],"up" , -100,"ut" , 50,"cw" , xfpdf_charwidths[xfontkey]);
				}
			else
				this.Error("Undefined font: " + xfamily + " " + xstyle);
			}
		 this.FontFamily=xfamily;
		 this.FontStyle=xstyle;
		 this.FontSizePt=xsize;
		 this.FontSize=(xsize)/this.k;
		 this.CurrentFont=this.fonts[xfontkey];
		if(this.page>0)this._out(lib.sprintf("BT /F%d %.2f Tf ET",this.CurrentFont["i"],this.FontSizePt));
		}

	this.SetFontSize=function SetFontSize(xsize)
		{
		if(this.FontSizePt==xsize)return;
		 this.FontSizePt=xsize;
		 this.FontSize=(xsize)/this.k;
		if(this.page>0)this._out(lib.sprintf("BT /F%d %.2f Tf ET",this.CurrentFont["i"],this.FontSizePt));
		}

	this.AddLink=function AddLink()
		{
		xn=lib.count(this.links)+1;
		 this.links[xn]=new Array(0,0);
		return xn;
		}

	this.SetLink=function SetLink(xlink , xy , xpage)
		{
		if (arguments.length<2) {xy=0};
		if (arguments.length<3) {xpage=-1};

		if(xy==-1)xy=this.y;
		if(xpage==-1)xpage=this.page;
		 this.links[xlink]=new Array(xpage,xy);
		}

	this.Link=function Link(xx , xy , xw , xh , xlink)
		{
		 if (!lib.is_array(this.PageLinks[this.page]))this.PageLinks[this.page]=new Array()
		 this.PageLinks[this.page][lib.count(this.PageLinks[this.page])]=new Array(xx*this.k,this.hPt-xy*this.k,xw*this.k,xh*this.k,xlink);
		}

	this.Text=function Text(xx , xy , xtxt)
		{
		xtxt=lib.str_replace(")","\\)",lib.str_replace("(","\\(",lib.str_replace("\\","\\\\",xtxt)));
		xs=lib.sprintf("BT %.2f %.2f Td (%s) Tj ET",xx*this.k,(this.h-xy)*this.k,xtxt);
		if(this.underline && xtxt!="")xs+=" " + this._dounderline(xx,xy,xtxt);
		if(this.ColorFlag)xs="q " + this.TextColor + " " + xs + " Q";
		 this._out(xs);
		}

	this.Cell=function Cell(xw , xh , xtxt , xborder , xln , xalign , xfill , xlink)
		{
		if (arguments.length<2) {xh=0};
		if (arguments.length<3) {xtxt=""};
		if (arguments.length<4) {xborder=0};
		if (arguments.length<5) {xln=0};
		if (arguments.length<6) {xalign=""};
		if (arguments.length<7) {xfill=0};
		if (arguments.length<8) {xlink=""};
		xk=this.k;
		if((this.y)+(xh)>this.PageBreakTrigger && !this.InFooter && this.AcceptPageBreak())
			{
			xx=this.x;
			xws=this.ws;
			if(xws>0)
				{
				 this.ws=0;
				 this._out("0 Tw");
				}
			 this.AddPage(this.CurOrientation);
			 this.x=xx;
			if(xws>0)
				{
				 this.ws=xws;
				 this._out(lib.sprintf("%.3f Tw",xws*xk));
				}
			}
		if(xw==0)xw=this.w-this.rMargin-this.x;
		xs="";
		if(xfill==1 || xborder==1)
			{
			if(xfill==1)xop=(xborder==1)?"B":"f";
			else xop="S";
			xs=lib.sprintf("%.2f %.2f %.2f %.2f re %s ",this.x*xk,(this.h-this.y)*xk,xw*xk,-xh*xk,xop);
			}
		if(lib.is_string(xborder))
			{
			xx=this.x;
			xy=this.y;
			if(lib.is_int(lib.strpos(xborder,"L")))xs+=lib.sprintf("%.2f %.2f m %.2f %.2f l S ",xx*xk,(this.h-xy)*xk,xx*xk,(this.h-(xy+xh))*xk);
			if(lib.is_int(lib.strpos(xborder,"T")))xs+=lib.sprintf("%.2f %.2f m %.2f %.2f l S ",xx*xk,(this.h-xy)*xk,(xx+xw)*xk,(this.h-xy)*xk);
			if(lib.is_int(lib.strpos(xborder,"R")))xs+=lib.sprintf("%.2f %.2f m %.2f %.2f l S ",(xx+xw)*xk,(this.h-xy)*xk,(xx+xw)*xk,(this.h-(xy+xh))*xk);
			if(lib.is_int(lib.strpos(xborder,"B")))xs+=lib.sprintf("%.2f %.2f m %.2f %.2f l S ",xx*xk,(this.h-(xy+xh))*xk,(xx+xw)*xk,(this.h-(xy+xh))*xk);
			}
		if(xtxt!="")
			{
			if(xalign=="R"){xdx=(xw)-(this.cMargin)-(this.GetStringWidth(xtxt))};
			else
			{
			if(xalign=="C") {
				xdx=((xw)-(this.GetStringWidth(xtxt)))/2
			};
			else {xdx=(this.cMargin);}
			}
			xtxt=lib.str_replace(")","\\)",lib.str_replace("(","\\(",lib.str_replace("\\","\\\\",xtxt)));
			if(this.ColorFlag)xs+="q " + this.TextColor + " ";
			xs+=lib.sprintf("BT %.2f %.2f Td (%s) Tj ET",(this.x+xdx)*xk,(this.h-(this.y+ .5*xh+.3*this.FontSize))*xk,xtxt);
			if(this.underline)xs+=" " + this._dounderline(this.x+xdx,this.y+ .5*xh+.3*this.FontSize,xtxt);
			if(this.ColorFlag)xs+=" Q";
			if(xlink)this.Link((this.x)+(xdx),(this.y) + .5*(xh)- + .5*(this.FontSize),this.GetStringWidth(xtxt),(this.FontSize),xlink);
			}
		if(xs!="")this._out(xs);
		this.lasth=xh;
		if(xln>0)
			{
			this.y= this.y + xh ;
			if(xln==1)this.x=this.lMargin;
			}
		else{this.x = this.x + (xw);}
		}

	this.MultiCell=function MultiCell(xw , xh , xtxt , xborder , xalign , xfill)
		{
		var xi;
		var xnb;
		var xs;
		var xsep;
		var xi;
		var xj;
		var xl;
		var xns;
		var xnl;
		var xcw;
		var ws;
		if (arguments.length<4) {xborder=0};
		if (arguments.length<5) {xalign="J"};
		if (arguments.length<6) {xfill=0};

		xcw=this.CurrentFont["cw"];
		if(xw==0)xw=this.w-this.rMargin-this.x;
		xwmax=(xw-2*this.cMargin)*1000/this.FontSize;
		xs=lib.str_replace("\r","",xtxt);
		xnb=lib.strlen(xs);
		if(xnb>0 && xs.charAt(xnb-1)=="\n")xnb--;
		xb=0;
		if(xborder)
			{
			if(xborder==1)
				{

				xborder="LTRB";
				xb="LRT";
				xb2="LR";
				}
			else

				{
				xb2="";
				if(lib.is_int(lib.strpos(xborder,"L"))){xb2+="L"};
				if(lib.is_int(lib.strpos(xborder,"R"))){xb2+="R"};
				xb=(lib.is_int(lib.strpos(xborder,"T"))?xb2 + "T":xb2);
				}
			}
		xsep=-1;
		xi=0;
		xj=0;
		xl=0;
		xns=0;
		xnl=1;
		while(xi<xnb)
			{
			xc=xs.charAt(xi);
			if(xc=="\n")
				{
				if(this.ws>0)
					{
					 this.ws=0;
					 this._out("0 Tw");
					}
				 this.Cell(xw,xh,lib.substr(xs,xj,xi-xj),xb,2,xalign,xfill);
				 if (this.Interlinea>0)this.Ln(this.Interlinea);
				xi++;
				xsep=-1;
				xj=xi;
				xl=0;
				xns=0;
				xnl++;
				if(xborder && xnl==2)xb=xb2;
				continue;
				}
			if(xc==" ")
				{
				xsep=xi;
				xls=xl;
				xns++;
				}
			xl+=(xcw[xc])
			if(xl>xwmax)
				{
				if(xsep==-1)
					{
					if(xi==xj)xi++;
					if(this.ws>0)
						{
						 this.ws=0;
						 this._out("0 Tw");
						}
					 this.Cell(xw,xh,lib.substr(xs,xj,xi-xj),xb,2,xalign,xfill);
					 if (this.Interlinea>0)this.Ln(this.Interlinea);
					}
				else

					{
					if(xalign=="J")
						{
						 this.ws=(xns>1)?((xwmax)-(xls))/1000*(this.FontSize)/((xns)-1):0;
						 this._out(lib.sprintf("%.3f Tw",(this.ws)*this.k));
						}

					 this.Cell(xw,xh,lib.substr(xs,xj,xsep-xj),xb,2,xalign,xfill);
					 if (this.Interlinea>0)this.Ln(this.Interlinea);
					 xi=xsep+1;
					}
				xsep=-1;
				xj=xi;
				xl=0;
				xns=0;
				xnl++;
				if(xborder && xnl==2){xb=xb2;};
				}
			else
				xi++;
			}
		if(this.ws>0)
			{
			 this.ws=0;
			 this._out("0 Tw");
			}
		if(xborder && lib.is_int(lib.strpos(xborder,"B")))xb+="B";
		 this.Cell(xw,xh,lib.substr(xs,xj,xi),xb,2,xalign,xfill);
		 if (this.Interlinea>0)this.Ln(this.Interlinea);
		 this.x=this.lMargin;
		}

	this.Write=function Write(xh , xtxt , xlink)
		{
		var xi;
		if (arguments.length<3) {xlink=""};

		var xcw=this.CurrentFont["cw"];
		var xw=(this.w)-(this.rMargin)-(this.x);
		var xwmax=(xw-2*this.cMargin)*1000/this.FontSize;
		var xs=lib.str_replace("\r","",xtxt);
		var xnb=lib.strlen(xs);
		var xsep=-1;
		var xi=0;
		var xj=0;
		var xl=0;
		var xnl=1;
		while(xi<xnb)
			{
			xc=xs.charAt(xi)
			if(xc=="\n")
				{
				this.Cell(xw,xh,lib.substr(xs,xj,xi-xj),0,2,"",0,xlink);
				xi++;
				xsep=-1;
				xj=xi;
				xl=0;
				if(xnl==1)
					{
					 this.x=this.lMargin;
					xw=this.w-this.rMargin-this.x;
					xwmax=(xw-2*this.cMargin)*1000/this.FontSize;
					}
				xnl++;
				continue;
				}
			if(xc==" ")
				{
				xsep=xi;
				xls=xl;
				}

			xl+=(xcw[xs.charAt(xi)]);
			if(xl>xwmax)
				{
				if(xsep==-1)
					{
					if(this.x>this.lMargin)
						{
						 this.x=this.lMargin;
						 this.y+=xh;
						xw=this.w-this.rMargin-this.x;
						xwmax=(xw-2*this.cMargin)*1000/this.FontSize;
						xi++;
						xnl++;
						continue;
						}
					if(xi==xj)xi++;
					 this.Cell(xw,xh,lib.substr(xs,xj,xi-xj),0,2,"",0,xlink);
					}
				else

					{
					 this.Cell(xw,xh,lib.substr(xs,xj,xsep-xj),0,2,"",0,xlink);
					xi=xsep+1;
					}
				xsep=-1;
				xj=xi;
				xl=0;
				if(xnl==1)
					{
					 this.x=this.lMargin;
					xw=this.w-this.rMargin-this.x;
					xwmax=(xw-2*this.cMargin)*1000/this.FontSize;
					}
				xnl++;
				}
			else {xi++}
			}
		if(xi!=xj)this.Cell(xl/1000*this.FontSize,xh,lib.substr(xs,xj),0,0,"",0,xlink);
		}

	this.Image=function Image(xfile , xx , xy , xw , xh , xtype , xlink)
		{
		if (arguments.length<5){xh=0};
		if (arguments.length<6){xtype=""};
		if (arguments.length<7){xlink=""};

		if(!lib.isset(this.images[xfile]))
			{
			if(xtype=="")
				{
				xpos=lib.strrpos(xfile,".");
				if(!xpos)this.Error("Image file has no extension and no type was specified: " + xfile);
				xtype=lib.substr(xfile,xpos+1);
				}
			xtype=xtype.toLowerCase();
			if(xtype=="jpg" || xtype=="jpeg")xinfo=this._parsejpg(xfile);
			else this.Error("Unsupported image file type: " + xtype);
			xinfo["i"]=lib.count(this.images)+1;
			 this.images[xfile]=xinfo;
			}
		else
		xinfo=this.images[xfile];
		if(xw==0)xw=xh*xinfo["w"]/xinfo["h"];
		if(xh==0)xh=xw*xinfo["h"]/xinfo["w"];
		 this._out(lib.sprintf("q %.2f 0 0 %.2f %.2f %.2f cm /I%d Do Q",xw*this.k,xh*this.k,xx*this.k,(this.h-(xy+xh))*this.k,xinfo["i"]));
		if(xlink)this.Link(xx,xy,xw,xh,xlink);
		}

	this.Ln=function Ln(xh)
		{
		if (arguments.length<1) {xh=""};

		 this.x=this.lMargin;
		if(lib.is_string(xh))this.y+=this.lasth;
		else
			this.y+=xh;
		}
	this.GetX=function GetX(){return this.x;}
	this.SetX=function SetX(xx)
		{
		if(xx>=0)this.x=xx;
		else
			this.x=this.w+xx;
		}
	this.GetY=function GetY(){return this.y;}
	this.SetY=function SetY(xy)
		{
		this.x=this.lMargin;
		if(xy>=0)this.y=xy;
		else
			this.y=this.h+xy;
		}
	this.SetXY=function SetXY(xx , xy)
		{
		 this.SetY(xy);
		 this.SetX(xx);
		}
	this.Output=function Output(xfile , xdownload , Overwrite)
		{
		if (arguments.length<3) {
		Overwrite=true;
			if (arguments.length<2) {
				xdownload=false;
				if (arguments.length<1){xfile=""};
			}
		}
		;
		if(this.state<3)this.Close();
		if(xfile!=""){ // <<< alteração aqui 
			if(xdownload){
						Response.ContentType = "application/octet-stream";
						Response.AddHeader("Content-disposition", "attachment; filename=" + xfile);
					}
					else
					{
						Response.ContentType = "application/pdf"
						Response.AddHeader("Content-Disposition","inline");
					}
			if (!this.hasBinary){
				Response.Write(this.buffer)}
			else{
				xfile=Server.MapPath(lib.fso.GetTempName())
				xf=lib.fopen(xfile,"wb");
				if(xf.number)this.Error("Unable to create output file: " + xfile);
				lib.fwrite(xf,this.buffer);
				lib.fclose(xf);
				outB = Server.CreateObject("ADODB.Stream")
				outB.Type = 1
				outB.Open()
				outB.LoadFromFile (xfile)
				Response.BinaryWrite(outB.Read())
				outB.Close()
				lib.fso.DeleteFile(xfile);
				}
		}
			else

				{
				xf=lib.fopen(xfile,"wb");
				if(xf.number)this.Error("Unable to create output file: " + xfile);
				lib.fwrite(xf,this.buffer);
				lib.fclose(xf);
				}
		}

	this.clearBuffer=function clearBuffer(){this.buffer='';}

	this._begindoc=function _begindoc()
		{
		 this.state=1;
		 this._out("%PDF-1.3");
		}

	this._putpages=function _putpages()
		{
		xnb=this.page;
		if(!lib.empty(this.AliasNbPages))
			{
			for(xn=1;xn<=xnb;xn++)this.pages[xn]=lib.str_replace(this.AliasNbPages,xnb,this.pages[xn]);
			}
		if(this.DefOrientation=="P")
			{
			xwPt=this.fwPt;
			xhPt=this.fhPt;
			}
		else

			{
			xwPt=this.fhPt;
			xhPt=this.fwPt;
			}
		xfilter=(this.compress)?"/Filter /FlateDecode ":
		"";
		for(xn=1;xn<=xnb;xn++)
			{
			 this._newobj();
			 this._out("<</Type /Page");
			 this._out("/Parent 1 0 R");
			if(lib.isset(this.OrientationChanges[xn]))this._out(lib.sprintf("/MediaBox [0 0 %.2f %.2f]",xhPt,xwPt));
			 this._out("/Resources 2 0 R");
			if(this.PageLinks[xn])
				{
				xannots="/Annots [";
				for(xpl in this.PageLinks[xn])
					{
					xpl = this.PageLinks[xn][xpl]
					xrect=lib.sprintf("%.2f %.2f %.2f %.2f",xpl[0],xpl[1],xpl[0]+xpl[2],xpl[1]-xpl[3]);
					xannots+="<</Type /Annot /Subtype /Link /Rect [" + xrect + "] /Border [0 0 0] ";
					if(lib.is_string(xpl[4]))xannots+="/A <</S /URI /URI " + this._textstring(xpl[4]) + ">>>>";
					else
						{
						xl=this.links[xpl[4]];
						xh=(this.OrientationChanges[xl.charAt(0)]?xwPt:xhPt);
						xannots+=lib.sprintf("/Dest [%d 0 R /XYZ 0 %.2f null]>>",1+2*xl[0],xh-xl[1]*this.k);
						}
					}
				 this._out(xannots + "]");
				}
			 this._out("/Contents " + (this.n+1) + " 0 R>>");
			 this._out("endobj");
			 xp=(this.compress)?this.gzcompress(this.pages[xn]):
			 this.pages[xn];
			 this._newobj();
			 this._out("<<" + xfilter + "/Length " + lib.strlen(xp) + ">>");
			 this._putstream(xp);
			 this._out("endobj");
			}
		 this.offsets[1]=lib.strlen(this.buffer);
		 this._out("1 0 obj");
		 this._out("<</Type /Pages");
		xkids="/Kids [";
		for(xi=0;xi<xnb;xi++)xkids+=(3+2*xi) + " 0 R ";
		 this._out(xkids + "]");
		 this._out("/Count " + xnb);
		 this._out(lib.sprintf("/MediaBox [0 0 %.2f %.2f]",xwPt,xhPt));
		 this._out(">>");
		 this._out("endobj");
		}

	this._putfonts=function _putfonts()
		{
		xnf=this.n;
		for(xdiff in this.diffs)
			{
			xdiff = this.diffs[xdiff]
			this._newobj();
			this._out("<</Type /Encoding /BaseEncoding /WinAnsiEncoding /Differences [" + xdiff + "]>>");
			this._out("endobj");
			}
		for(xfile  in this.FontFiles)
			{
			xinfo = this.FontFiles[xfile]
			this._newobj();
			this.FontFiles[xfile]["n"]=this.n;
			xfile=this.FONTPATH + xfile;
			xsize=lib.filesize(xfile);
			if(!xsize)this.Error("Font file not found");
			this._out("<</Length " + xsize);
			if(lib.substr(xfile,-2)==".z")this._out("/Filter /FlateDecode");
			this._out("/Length1 " + xinfo["length1"]);
			if(lib.isset(xinfo["length2"]))this._out("/Length2 " + xinfo["length2"] + " /Length3 0");
			this._out(">>");
			this.hasBinary = true
			this._putstream(lib.readbinfile(xfile),-1);
			this._out("endobj");
			}
		for(xk  in this.fonts)
			{
			 xfont = this.fonts[xk]
			 this._newobj();
			 this.fonts[xk]["n"]=this.n;
			xname=xfont["name"];
			 this._out("<</Type /Font");
			 this._out("/BaseFont /" + xname);
			if(xfont["type"]=="core")
				{
				 this._out("/Subtype /Type1");
				if(xname!="Symbol" && xname!="ZapfDingbats")this._out("/Encoding /WinAnsiEncoding");
				}
			else

				{
				 this._out("/Subtype /" + xfont["type"]);
				 this._out("/FirstChar 32");
				 this._out("/LastChar 255");
				 this._out("/Widths " + (this.n+1) + " 0 R");
				 this._out("/FontDescriptor " + (this.n+2) + " 0 R");
				if(xfont["enc"])
					{
					//debug(xfont["diff"])
					if(xfont["diff"])this._out("/Encoding " + (xnf+xfont["diff"]) + " 0 R");
					else this._out("/Encoding /WinAnsiEncoding");
					}
				}
			 this._out(">>");
			 this._out("endobj");
			if(xfont["type"]!="core")
				{
				this._newobj();
				xcw=xfont["cw"];
				xs="[";

				for(xi=32;xi<=255;xi++)
				{
					xs+= xcw[String.fromCharCode(xi)] + " ";
				}
				this._out(xs + "]");
				this._out("endobj");
				this._newobj();
				xs="<</Type /FontDescriptor /FontName /" + xname;
				for(xk  in xfont["desc"])
				{
				xv=xfont["desc"][xk];
				xs += " /" + xk + " " +xv;
				}
				xfile=xfont["file"];
				if(xfile)xs+=" /FontFile" + (xfont["type"]=="Type1"?"":"2") + " " + this.FontFiles[xfile]["n"] + " 0 R";
				 this._out(xs + ">>");
				 this._out("endobj");
				}
			}
		}


	this._putimages=function _putimages()
		{
		xfilter=(this.compress)?"/Filter /FlateDecode ":"";
		for(xfile  in this.images)
			{
			 xinfo = this.images[xfile]

			 this._newobj();
			 this.images[xfile]["n"]=this.n;
			 this._out("<</Type /XObject");
			 this._out("/Subtype /Image");
			 this._out("/Width " + xinfo["w"]);
			 this._out("/Height " + xinfo["h"]);
			if(xinfo["cs"]=="Indexed")
				{
				this._out("/ColorSpace [/Indexed /DeviceRGB " + (lib.strlen(xinfo["pal"])/3-1) + " " + (this.n+1) + " 0 R]");
				}
			else
				{
				 this._out("/ColorSpace /" + xinfo["cs"]);
				if(xinfo["cs"]=="DeviceCMYK")this._out("/Decode [1 0 1 0 1 0 1 0]");
				}

			 this._out("/BitsPerComponent " + xinfo["bpc"]);
			 this._out("/Filter /" + xinfo["f"]);
			if(lib.isset(xinfo["parms"]))this._out(xinfo["parms"]);
			if(lib.isset(xinfo["trns"]) && lib.is_array(xinfo["trns"]))
				{
				xtrns="";
				for(xi=0;xi<lib.count(xinfo["trns"]);xi++)xtrns+=xinfo["trns"][xi] + " " + xinfo["trns"][xi] + " ";
				 this._out("/Mask [" + xtrns + "]");
				}
			 this._out("/Length " + xinfo["size"] + ">>");
			 this._putstream(xinfo["data"]);
			 this.hasBinary = true;
			 this._out("endobj");
			if(xinfo["cs"]=="Indexed")
				{
				 this._newobj();
				xpal=(this.compress)?gzcompress(xinfo["pal"]):
				xinfo["pal"];
				 this._out("<<" + xfilter + "/Length " + lib.strlen(xpal) + ">>");
				 this._putstream(xpal);
				 this._out("endobj");
				}
			}
		}

	this._putresources=function _putresources()
		{
		this._putfonts();
		this._putimages();
		this.offsets[2]=lib.strlen(this.buffer);
		this._out("2 0 obj");
		this._out("<</ProcSet [/PDF /Text /ImageB /ImageC /ImageI]");
		this._out("/Font <<");
		for(xfont in this.fonts)
		{
		xfont = this.fonts[xfont]
		this._out('/F'+ xfont['i'] + ' ' + xfont['n'] + ' 0 R');
		}
		this._out(">>");
		if(lib.count(this.images))
			{
			 this._out("/XObject <<");
			for(ximage in this.images){
			 ximage = this.images[ximage]
			 this._out("/I" + ximage["i"] + " " + ximage["n"] +" 0 R");
			 }
			 this._out(">>");
			}
		 this._out(">>");
		 this._out("endobj");
		}

	this._putinfo=function _putinfo()
		{
		 this._out("/Producer " + this._textstring("FPDF for ASP v." + this.Version + " [more at https://github.com/matheuseduardo/fpdf-asp]"));
		if(!lib.empty(this.title))this._out("/Title " + this._textstring(this.title));
		if(!lib.empty(this.subject))this._out("/Subject " + this._textstring(this.subject));
		if(!lib.empty(this.author))this._out("/Author " + this._textstring(this.author));
		if(!lib.empty(this.keywords))this._out("/Keywords " + this._textstring(this.keywords));
		if(!lib.empty(this.creator))this._out("/Creator " + this._textstring(this.creator));
		 this._out("/CreationDate " + this._textstring("D:" + lib.date("YmdHis")));
		}

	this._putcatalog=function _putcatalog()
		{
		 this._out("/Type /Catalog");
		 this._out("/Pages 1 0 R");
		if(this.ZoomMode=="fullpage")this._out("/OpenAction [3 0 R /Fit]");
		else if(this.ZoomMode=="fullwidth")this._out("/OpenAction [3 0 R /FitH null]");
		else if(this.ZoomMode=="real")this._out("/OpenAction [3 0 R /XYZ null null 1]");
		else if(!is_string(this.ZoomMode))this._out("/OpenAction [3 0 R /XYZ null null " + (this.ZoomMode/100) + "]");
		if(this.LayoutMode=="single")this._out("/PageLayout /SinglePage");
		else if(this.LayoutMode=="continuous")this._out("/PageLayout /OneColumn");
		else if(this.LayoutMode=="two")this._out("/PageLayout /TwoColumnLeft");
		}

	this._puttrailer=function _puttrailer()
		{
		 this._out("/Size " + (this.n+1));
		 this._out("/Root " + this.n + " 0 R");
		 this._out("/Info " + (this.n-1) + " 0 R");
		}

	this._enddoc=function _enddoc()
		{
		 this._putpages();
		 this._putresources();
		 this._newobj();
		 this._out("<<");
		 this._putinfo();
		 this._out(">>");
		 this._out("endobj");
		 this._newobj();
		 this._out("<<");
		 this._putcatalog();
		 this._out(">>");
		 this._out("endobj");
		xo=lib.strlen(this.buffer);
		 this._out("xref");
		 this._out("0 " + (this.n+1));
		 this._out("0000000000 65535 f ");
		for(xi=1;xi<=this.n;xi++)this._out(lib.sprintf("%010d 00000 n ",this.offsets[xi]));
		 this._out("trailer");
		 this._out("<<");
		 this._puttrailer();
		 this._out(">>");
		 this._out("startxref");
		 this._out(xo);
		 this._out("%%EOF");
		 this.state=3;
		}

	this._beginpage=function _beginpage(xorientation)
		{
		 this.page++;
		 this.pages[this.page]="";
		 this.state=2;
		 this.x=this.lMargin;
		 this.y=this.tMargin;
		 this.lasth=0;
		 this.FontFamily="";
		if(!xorientation)xorientation=this.DefOrientation;
		else
			{
			//xorientation=lib.strtoupper(xorientation)
			if(xorientation!=this.DefOrientation)this.OrientationChanges[this.page]=true;
			}

		if(xorientation!=this.CurOrientation)
			{
			if(xorientation=="P")
				{
				 this.wPt=this.fwPt;
				 this.hPt=this.fhPt;
				 this.w=this.fw;
				 this.h=this.fh;
				}
			else

				{
				 this.wPt=this.fhPt;
				 this.hPt=this.fwPt;
				 this.w=this.fh;
				 this.h=this.fw;
				}
			 this.PageBreakTrigger=this.h-this.bMargin;
			 this.CurOrientation=xorientation;
			}
		}

	this._endpage=function _endpage(){this.state=1;}

	this._newobj=function _newobj()
		{
		 this.n++;
		 this.offsets[this.n]=lib.strlen(this.buffer);
		 this._out(this.n + " 0 obj");
		}

	this._dounderline=function _dounderline(xx , xy , xtxt)
		{
		xup=this.CurrentFont["up"];
		xut=this.CurrentFont["ut"];
		xw=this.GetStringWidth(xtxt)+this.ws*lib.substr_count(xtxt," ");
		return lib.sprintf("%.2f %.2f %.2f %.2f re f",xx*this.k,(this.h-(xy-xup/1000*this.FontSize))*this.k,xw*this.k,-xut/1000*this.FontSizePt);
		}

	this._parsejpg=function _parsejpg(xfile)
		{
		xa= new cImage();
		xa.Open(xfile);
		if(!xa)this.Error("Missing or incorrect image file: " + xfile);
		if(xa["id"]!=2)this.Error("Not a JPEG file: " + xfile);
		if(!lib.isset(xa["channels"]) || xa["channels"]==3)xcolspace="DeviceRGB";
		else if(xa["channels"]==4)xcolspace="DeviceCMYK";
		else xcolspace="DeviceGray";
		xbpc=(xa["bits"]?xa["bits"]:8);
		xdata=xa.GetBuffer()
		size=xa.size;
		xa.Close();
		return lib.newArray("w" , xa["width"] ,"h" , xa["height"],"cs" , xcolspace,"bpc" , xbpc,"f" , "DCTDecode","data" , xdata,"size",size);
		}

	this._textstring=function _textstring(xs){return "(" + this._escape(xs) + ")";}

	this._escape=function _escape(xs){
		return lib.str_replace(")","\\)",lib.str_replace("(","\\(",lib.str_replace("\\","\\\\",xs)));
	}

	this._putstream=function _putstream(xs)
		{
		 this._out("stream");
		 this._out(xs);
		 this._out("endstream");
		}

	this._out=function _out(xs,isBinary)
		{
		if(this.state==2)
			{this.pages[this.page]+=xs + "\n";}
		else
			{
			this.buffer+=xs + "\n";
			}
		}

	this.GetBuffer=function GetBuffer(){
		return this.buffer;
	}

	this.GetMargin=function GetMargin(s){
		if (arguments.length<1){s="l";}
		else{s = s.toLowerCase();}
		switch(s){
			case "l":
			case "left":
				return this.lMargin;
			case "r":
			case "right":
				return this.rMargin;
			case "b":
			case "bottom":
				return this.bMargin;
			case "t":
			case "top":
				return this.tMargin;
		}
	}

	this._LoadExtension=function _LoadExtension(path){
		eval(lib.readtextfile(path));
	}

	this.LoadExtension=function LoadExtends(path){
		this._LoadExtension(this.EXTENDSPATH +path+".ext");
	}
	this.LoadModels=function LoadModels(path){
		this._LoadExtension(this.MODELSPATH +path+".mod");
	}
	this.ExtendsCode=function ExtendsCode(AddTo,CodeAdd){
		Code = new String(eval("this." + AddTo));
		CodeAdd = new String(CodeAdd);
		pI = CodeAdd.indexOf("{")+1;pE = CodeAdd.lastIndexOf("}")
		sToAdd = CodeAdd.substring(pI,pE)
		pE = Code.lastIndexOf("}")
		eval("this." + AddTo + "=" + Code.substring(0,pE) + "\n" + sToAdd +"}");
	}
}

</script>
