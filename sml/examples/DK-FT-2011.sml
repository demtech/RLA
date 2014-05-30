(* RLA Denmark *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

structure DKFT2011 = 
struct

  structure D = dHondt
  structure U = Util

  val CopenhagenCityStorkreds = ([ 80705.0, 71264.0, 23262.0, 52870.0, 24882.0, 1185.0, 35887.0,  64914.0, 70831.0], 15)
  val CopenhagenAreaStorkreds = ([ 81557.0, 33992.0, 21763.0, 27767.0, 16703.0, 1086.0, 40444.0,  69948.0, 23221.0], 12)
  val NordsealandStorkreds    = ([ 54182.0, 33537.0, 19765.0, 21012.0, 20613.0, 1171.0, 30279.0,  91870.0, 15062.0], 10)
  val BornholmStorkreds       = ([  9801.0,  1509.0,   580.0,  2011.0,   509.0,  681.0,  2972.0,   7398.0,  1992.0], 2)  
  val SealandStorkreds        = ([133571.0, 39840.0, 24863.0, 51952.0, 23857.0, 2022.0, 85571.0, 139888.0, 29959.0], 20)
  val FynsStorkreds           = ([ 89577.0, 26658.0, 16033.0, 32990.0, 13164.0, 1330.0, 38978.0,  76845.0, 19914.0], 12)
  val SouthJyllandsStorkreds  = ([108937.0, 29742.0, 17905.0, 34717.0, 21912.0, 4714.0, 66666.0, 149148.0, 17266.0], 18)
  val EastJyllandsStorkreds   = ([131338.0, 50350.0, 18028.0, 43364.0, 23682.0, 3090.0, 50274.0, 131674.0, 30471.0], 18)
  val WestJyllandsStorkreds   = ([ 76208.0, 24090.0, 12677.0, 26819.0, 16061.0, 9664.0, 40378.0, 113443.0, 11505.0], 13)
  val NordJyllandsStorkreds   = ([113739.0, 25716.0, 20171.0, 32690.0, 15202.0, 3127.0, 45277.0, 102686.0, 16639.0], 14)

  val mCopenhagenCityStorkreds = D.margins CopenhagenCityStorkreds
  val mCopenhagenAreaStorkreds = D.margins CopenhagenAreaStorkreds
  val mNordsealandStorkreds = D.margins NordsealandStorkreds
  val mBornholmStorkreds = D.margins BornholmStorkreds
  val mSealandStorkreds = D.margins SealandStorkreds
  val mFynsStorkreds = D.margins FynsStorkreds
  val mSouthJyllandsStorkreds = D.margins SouthJyllandsStorkreds
  val mEastJyllandsStorkreds = D.margins EastJyllandsStorkreds
  val mWestJyllandsStorkreds = D.margins WestJyllandsStorkreds
  val mNordJyllandsStorkreds = D.margins NordJyllandsStorkreds

  val allmargins = map (fn (a,b,c,d) => b) [mCopenhagenCityStorkreds,
					    mCopenhagenAreaStorkreds,
					    mNordsealandStorkreds,
					    mBornholmStorkreds,
					    mSealandStorkreds,
					    mFynsStorkreds ,
					    mSouthJyllandsStorkreds,
					    mEastJyllandsStorkreds,
					    mWestJyllandsStorkreds, 
					    mNordJyllandsStorkreds]   

  val allmargins' = U.flatten allmargins
  val allmargins'' = U.sort (fn (x,y) => Real.< (x,y)) allmargins'
end