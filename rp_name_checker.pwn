/*
	* Author: Kristijan Stipić
	* Date: 09.03.2013.
	__________________________________
	Slučaj 1: Ime i prezime su ispravni, ime je uspješno prošlo provjeru.
	Slučaj 2: Ime nije prošlo provjeru jer nema povlaku za odvajanje imena od prezimena.
	Slučaj 3: Ime nije prošlo provjeru jer ima više od jedne povlake
	Slučaj 4: Ime nije prošlo provjeru jer sadržava zabranjene znakove (brojeve, [, ]...)
	Slučaj 5: Prvo slovo imena ili prezimena ne počinje velikim slovom
	Slučaj 6: Slova poslije imena ili prezimena moraju biti mala slova
	Slučaj 7: Povlaka je prvo ili zadnje slovo u nicku
	Slučaj 8: Ime ima manje od 3 slova
	Slučaj 9: Prezime ima manje od 3 slova

*/
stock isRoleplayName(playerid, const escape[MAX_PLAYER_NAME] = "-1", bool:sensitive = true, bool:autoRegulation = true) {
	  #define SL@Y__KLJUC(%0) ("_V([%0])V_")
	  new
		 name[MAX_PLAYER_NAME] = "\0";
      GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	  if(strcmp(name, escape, sensitive) == 0 || strcmp(name, SL@Y__KLJUC(playerid), true) == 0) return (1);

      new
	     s = strlen(name), coating[2], i = (0), Signs = (0), prohibitedSigns[20] =
	     { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '[', ']', '.', ')', '(',
	       '@', '{', '}', '$', '€' }, SignCounter[2];

      coating[0] = strfind(name, "_", true);
      coating[1] = strfind(name, "_", true, coating[0]+1);

	  if(coating[0] == -1) return (2);
	  else if(coating[1] != -1) return (3);
	  else if(name[0] == '_' || name[s-1] == '_') return (7);
	  else
	  {
		   do
		   {
				while(Signs < sizeof(prohibitedSigns))
				{
                     if(name[i] == prohibitedSigns[Signs]) return (4);
                     ++ Signs;
				}
				if(i == 0 || i == coating[0]+1)
				{
			         if(name[i] < 'A' || name[i] > 'Z')
					 {
						  if(autoRegulation == false) return (5);
						  else if(autoRegulation != false)
						  {
						       SetPlayerName(playerid, SL@Y__KLJUC(playerid));
						       name[i] = toupper(name[i]);
						  }
					 }
				}
				else if(i != 0 && i != coating[0])
				{
					 if(name[i] < 'a' || name[i] > 'z')
					 {
                          if(autoRegulation == false) return (6);
						  else if(autoRegulation != false)
						  {
						      SetPlayerName(playerid, SL@Y__KLJUC(playerid));
						      name[i] = tolower(name[i]);
		                  }
					 }
					 if(i != 0 && i < coating[0]+1) ++ SignCounter[0];
					 else if(i != 0 && i > coating[0]+1) ++ SignCounter[1];
				}
				++ i;
		   }
		   while(i < s && name[i] != EOS);
		   if(SignCounter[0] < 2) return (8);
		   else if(SignCounter[1] < 2) return (9);
		   if(autoRegulation == true) SetPlayerName(playerid, name);
	  }
	  return (1);
}