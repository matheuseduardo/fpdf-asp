<script language="javascript" runat="server" charset="utf-8">
Math.hexdec = function(sHexNum) {return  parseInt(sHexNum, 16);}
Math.bindec = function(lBinaryNum) {return parseInt(lBinaryNum.toString(), 2);}
Math.deg2rad = function(fDegrees) {return  ((2 * Math.PI) / 360) * fDegrees;}
Math.dechex = function(lDecimalNum) {return lDecimalNum.toString(16);}
Math.getHex = function getHex(num){
   hexStr = "0123456789ABCDEF";
   hex="";
   if (num>=16) {
      hex = hexStr.substr(parseInt(num/16),1);
      num = num%16;
   }
   hex += hexStr.substr(num,1);

   return hex;
}
String.prototype.hexCodeAt = function(index) {
return eval("0x" + this.charCodeAt(0).toString(16));
}
</script>