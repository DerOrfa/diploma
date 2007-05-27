	cout << tex->dim.outer2inner_trans << endl;
	SGLVektor a=*EckVektoren.Vekt[0]-tex->dim.outer2inner_trans/2;
	GLdouble aX=a.SGLV_X/tex->dim.outer_bottom_right_back.SGLV_X;
	GLdouble aY=a.SGLV_Y/tex->dim.outer_top_left_front.SGLV_Y;
	GLdouble aZ=a.SGLV_Z/tex->dim.outer_top_left_front.SGLV_Z;
	
	SGLVektor b=*EckVektoren.Vekt[1]-tex->dim.outer2inner_trans/2;
	GLdouble bX=b.SGLV_X/tex->dim.outer_top_left_front.SGLV_X;
	GLdouble bY=b.SGLV_Y/tex->dim.outer_top_left_front.SGLV_Y;
	GLdouble bZ=b.SGLV_Z/tex->dim.outer_top_left_front.SGLV_Z;
	
	
	SGLVektor c=*EckVektoren.Vekt[2]-tex->dim.outer2inner_trans/2;
	GLdouble cX=c.SGLV_X/tex->dim.outer_top_left_front.SGLV_X;
	GLdouble cY=c.SGLV_Y/tex->dim.outer_bottom_right_back.SGLV_Y;
	GLdouble cZ=c.SGLV_Z/tex->dim.outer_top_left_front.SGLV_Z;
	
	SGLVektor d=*EckVektoren.Vekt[3]-tex->dim.outer2inner_trans/2;
	GLdouble dX=d.SGLV_X/tex->dim.outer_bottom_right_back.SGLV_X;
	GLdouble dY=d.SGLV_Y/tex->dim.outer_bottom_right_back.SGLV_Y;
	GLdouble dZ=d.SGLV_Z/tex->dim.outer_top_left_front.SGLV_Z;
	
	//Tex-Raum in Tex-Coord-Raum umrechnen Ursprung der Tex-Coord (0,0,0) ist linksobenvorn
	aX=.5+aX/2;aY=.5-aY/2;aZ=.5+aZ/2;
	bX=.5-bX/2;bY=.5-bY/2;bZ=.5+bZ/2;
	cX=.5-cX/2;cY=.5+cY/2;cZ=.5+cZ/2;
	dX=.5+dX/2;dY=.5+dY/2;dZ=.5+dZ/2;

/////////////////////////////////////////////////////////////////////////////////
	//Eigentlich sollte die textur immer GLvlVolumeTex sein, aber wenn die zwischendurch jemand böses austauscht ....
	assert(strcmp(Mat->tex->guesType(),typeid(GLvlVolumeTex).name())==0);
	GLvlVolumeTex *tex= (GLvlVolumeTex *)Mat->tex;
	
	//Raumcoord der Cam in Tex-Raum der Cam umrechnen
	cout << tex->dim.outer2inner_trans << endl;
	SGLVektor a=*EckVektoren.Vekt[0];
	cout << tex->dim.X.outer_mm_size*GLvlVolumeTex::GL_Coord_fact << endl;
	GLdouble aX=a.SGLV_X/-(tex->dim.X.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble aY=a.SGLV_Y/(tex->dim.Y.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble aZ=a.SGLV_Z/(tex->dim.Z.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	
	SGLVektor b=*EckVektoren.Vekt[1];
	GLdouble bX=b.SGLV_X/(tex->dim.X.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble bY=b.SGLV_Y/(tex->dim.Y.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble bZ=b.SGLV_Z/(tex->dim.Z.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	
	
	SGLVektor c=*EckVektoren.Vekt[2];
	GLdouble cX=c.SGLV_X/(tex->dim.X.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble cY=c.SGLV_Y/-(tex->dim.Y.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble cZ=c.SGLV_Z/(tex->dim.Z.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	
	SGLVektor d=*EckVektoren.Vekt[3];
	GLdouble dX=d.SGLV_X/-(tex->dim.X.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble dY=d.SGLV_Y/-(tex->dim.Y.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	GLdouble dZ=d.SGLV_Z/(tex->dim.Z.outer_mm_size*GLvlVolumeTex::GL_Coord_fact)*2;
	
	//Tex-Raum in Tex-Coord-Raum umrechnen Ursprung der Tex-Coord (0,0,0) ist linksobenvorn
	aX=.5+aX/2;aY=.5-aY/2;aZ=.5+aZ/2;
	
	
	
	//Raumcoord der Cam in Tex-Raum der Cam umrechnen
	SGLVektor a=*EckVektoren.Vekt[0]/GLvlVolumeTex::GL_Coord_fact;
	GLdouble aX=a.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble aY=a.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble aZ=a.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	SGLVektor b=*EckVektoren.Vekt[1]/GLvlVolumeTex::GL_Coord_fact;
	GLdouble bX=b.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble bY=b.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble bZ=b.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	
	SGLVektor c=*EckVektoren.Vekt[2]/GLvlVolumeTex::GL_Coord_fact;
	GLdouble cX=c.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble cY=c.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble cZ=c.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	SGLVektor d=*EckVektoren.Vekt[3]/GLvlVolumeTex::GL_Coord_fact;
	GLdouble dX=d.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble dY=d.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble dZ=d.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	//Tex-Raum in Tex-Coord-Raum umrechnen Ursprung der Tex-Coord (0,0,0) ist linksobenvorn
	aX=.5+aX;aY=.5-aY;aZ=.5+aZ;
	bX=.5+bX;bY=.5-bY;bZ=.5+bZ;
	cX=.5+cX;cY=.5-cY;cZ=.5+cZ;
	dX=.5+dX;dY=.5-dY;dZ=.5+dZ;

	bX=.5-bX/2;bY=.5-bY/2;bZ=.5+bZ/2;
	cX=.5-cX/2;cY=.5+cY/2;cZ=.5+cZ/2;
	dX=.5+dX/2;dY=.5+dY/2;dZ=.5+dZ/2;
	
/////////////////////////////////////////////////////////////////////////////////////	
	outer2inner_trans_mm=SGLVektor(
		X.endgap_mm-X.startgap_mm,//platz rechts (positiver quadrant)
		Y.startgap_mm-Y.endgap_mm, //platz unten (negativer quadrant) //eigentlich nich - HÄÄ
		Z.endgap_mm-Z.startgap_mm //platz hinten (pos quadrant)
	);

korr=dim.outer2inner_trans_mm*GLvlVolumeTex::GL_Coord_fact
a (a_vorher-korr) wurde aber durch GLvlVolumeTex::GL_Coord_fact und später durch 2 div => korr=dim.outer2inner_trans/2
		
==>		
	SGLVektor x=tex->dim.outer2inner_trans_mm/2.;
	
	SGLVektor a=*EckVektoren.Vekt[0]/GLvlVolumeTex::GL_Coord_fact-x;
	GLdouble aX=a.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble aY=a.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble aZ=a.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	SGLVektor b=*EckVektoren.Vekt[1]/GLvlVolumeTex::GL_Coord_fact-x;
	GLdouble bX=b.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble bY=b.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble bZ=b.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	
	SGLVektor c=*EckVektoren.Vekt[2]/GLvlVolumeTex::GL_Coord_fact-x;
	GLdouble cX=c.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble cY=c.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble cZ=c.SGLV_Z/tex->dim.Z.outer_mm_size;
	
	SGLVektor d=*EckVektoren.Vekt[3]/GLvlVolumeTex::GL_Coord_fact-x;
	GLdouble dX=d.SGLV_X/tex->dim.X.outer_mm_size;
	GLdouble dY=d.SGLV_Y/tex->dim.Y.outer_mm_size;
	GLdouble dZ=d.SGLV_Z/tex->dim.Z.outer_mm_size;

=>
outer2inner_trans_mm=SGLVektor(
		X.endgap_mm-X.startgap_mm,//platz rechts (positiver quadrant)
		Y.startgap_mm-Y.endgap_mm, //platz unten (negativer quadrant)
		Z.endgap_mm-Z.startgap_mm //platz hinten (pos quadrant)
	);

SGLVektor GLvlVolumeTex::weltKoord2texKoord(SGLVektor welt)
{
	SGLVektor x=dim.outer2inner_trans_mm/2.;
	
	SGLVektor a=welt/GLvlVolumeTex::GL_Coord_fact-x;
	SGLVektor ret(
		.5+(a.SGLV_X/dim.X.outer_mm_size),
		.5-(a.SGLV_Y/dim.Y.outer_mm_size),
		.5+(a.SGLV_Z/dim.Z.outer_mm_size)
	);
	return ret;
}


=>
outer2inner_trans_mm=SGLVektor(
	X.endgap_mm-X.startgap_mm,//platz rechts 
	Y.endgap_mm-Y.startgap_mm, //platz unten 
	Z.endgap_mm-Z.startgap_mm //platz hinten 
	);

SGLVektor GLvlVolumeTex::weltKoord2texKoord(SGLVektor welt)
{
	SGLVektor x=dim.outer2inner_trans_mm/2.;
	+
	SGLVektor a=welt/GLvlVolumeTex::GL_Coord_fact-x;
	SGLVektor ret(
		.5+(a.SGLV_X/dim.X.outer_mm_size),
		.5+(a.SGLV_Y/dim.Y.outer_mm_size),
		.5+(a.SGLV_Z/dim.Z.outer_mm_size)
	);
	return ret;
}
	
///////////////////////////////////////////////////////
die blending-Lösung für die texturen lag im konflikt mit DEPTH_TEST (auch transparente Pixel schreiben in den Tiefenpuffer - was dahinter liegt wird nich gez [wenn es später kommt])
=> glAlphaFunc(GL_GREATER) zeichnet Pixel mit gar nicht => schreiben nicht in den Tiefenpuffer 

////////Sichtrechteck
void SGLBaseCam::getViewRect(SGLVektor Ecken[4])
{
	SGLVektor PosVektor=getLookVektor();

	double betha = 90-Angle;
	double a=SIN(Angle)*PosVektor.Len();//die Gegenkatete des Dreiecks aus PosVektor und dem um PosVektor verschobenen UpVekt
	double DiagWinkel=ATAN(ViewFormat);//Der Winkel der Diagonalen des Sichtfeldes zur Senkrechte
	double c = a/SIN(90-DiagWinkel); //die Hypotenuse des Dreiecks aus Diagonalen und der Senkrechte

	Ecken[0]=UpVect.Rotate(PosVektor,360-DiagWinkel);
	Ecken[1]=UpVect.Rotate(PosVektor,DiagWinkel);
	Ecken[2]=UpVect.Rotate(PosVektor,180-DiagWinkel);
	Ecken[3]=UpVect.Rotate(PosVektor,180+DiagWinkel);
	Ecken[0]=(Ecken[0]*c)+LookAt;
	Ecken[1]=(Ecken[1]*c)+LookAt;
	Ecken[2]=(Ecken[2]*c)+LookAt;
	Ecken[3]=(Ecken[3]*c)+LookAt;
}
////////////////
void SGLBaseCam::getViewRect(SGLVektor Ecken[4])
{
	SGLVektor PosVektor=getLookVektor();

	double DiagWinkel=ATAN(ViewFormat);//Der Winkel der Diagonalen des Sichtfeldes zur Senkrechte
	double c = SIN(Angle)/COS(DiagWinkel)*PosVektor.Len(); //die Hypotenuse des Dreiecks aus Diagonalen und der Senkrechte

	Ecken[0]=UpVect.Rotate(PosVektor,360-DiagWinkel);
	Ecken[1]=UpVect.Rotate(PosVektor,DiagWinkel);
	Ecken[2]=UpVect.Rotate(PosVektor,180-DiagWinkel);
	Ecken[3]=UpVect.Rotate(PosVektor,180+DiagWinkel);
	Ecken[0]=(Ecken[0]*c)+LookAt;
	Ecken[1]=(Ecken[1]*c)+LookAt;
	Ecken[2]=(Ecken[2]*c)+LookAt;
	Ecken[3]=(Ecken[3]*c)+LookAt;
}


//welt-Screen-Umrechnung//////////////////////////////////////////////
SGLVektor SGLSpace::welt2Window(SGLVektor weltCoord)
{
	GLdouble model[16];
	GLdouble proj[16];
	GLint view[4];
	SGLVektor ret;

	GLenum error;
	glGetDoublev(GL_MODELVIEW_MATRIX,model);
	glGetDoublev(GL_PROJECTION_MATRIX,proj);
	glGetIntegerv(GL_VIEWPORT,view);
	
	if(gluProject(weltCoord.SGLV_X,weltCoord.SGLV_Y,weltCoord.SGLV_Z,model,proj,view,&ret.SGLV_X,&ret.SGLV_Y,&ret.SGLV_Z)==GL_FALSE)
	{SGLprintError("gluProject %s",gluErrorString(glGetError()));}
	return ret;
}

SGLVektor SGLSpace::Window2welt(SGLVektor windowCoord)
{
	GLdouble model[16];
	GLdouble proj[16];
	GLint view[4];
	SGLVektor ret;

	GLenum error;
	glGetDoublev(GL_MODELVIEW_MATRIX,model);
	glGetDoublev(GL_PROJECTION_MATRIX,proj);
	glGetIntegerv(GL_VIEWPORT,view);
	
	if(gluUnProject(windowCoord.SGLV_X,windowCoord.SGLV_Y,windowCoord.SGLV_Z,model,proj,view,&ret.SGLV_X,&ret.SGLV_Y,&ret.SGLV_Z)==GL_FALSE)
	{SGLprintError("gluProject %s",gluErrorString(glGetError()));}
	return ret;
}


/////////////////////////////////////////////////////////////////////////////////
/*!
    \fn SGLSpace::welt2Window(SGLVektor weltCoord)
 */
SGLVektor SGLSpace::welt2Window(SGLVektor weltCoord){return Window_welt_trans(weltCoord,false);}
SGLVektor SGLSpace::Window2welt(unsigned int X,unsigned int Y)
{
	SGLVektor V(X,Y,welt2Window(Camera->LookAt).SGLV_Z);
	return Window_welt_trans(V,true);
}
SGLVektor SGLSpace::Window2welt(SGLVektor windowCoord){return Window_welt_trans(windowCoord,true);}

SGLVektor SGLSpace::Window_welt_trans(SGLVektor Coord,bool toWelt)
{
	GLdouble model[16];
	GLdouble proj[16];
	GLint view[4];
	SGLVektor ret;

	GLenum oldmode=sglGeti(GL_MATRIX_MODE);
	Camera->loadView();
	
	GLenum error;
	glGetIntegerv(GL_VIEWPORT,view);
	glGetDoublev(GL_MODELVIEW_MATRIX,model);
	glGetDoublev(GL_PROJECTION_MATRIX,proj);
	
	GLboolean erg;
	if(toWelt)erg = gluUnProject(Coord.SGLV_X,view[3] - Coord.SGLV_Y - 1.,Coord.SGLV_Z,model,proj,view,&ret.SGLV_X,&ret.SGLV_Y,&ret.SGLV_Z);
	else gluProject(Coord.SGLV_X,Coord.SGLV_Y,Coord.SGLV_Z,model,proj,view,&ret.SGLV_X,&ret.SGLV_Y,&ret.SGLV_Z);
		
	if(erg==GL_FALSE){SGLprintError("Fehler beim Umrechnen der Coordinaten");}
	
	Camera->unloadView();
	glMatrixMode(oldmode);
	
	return ret;
}


///Cameraberechnungen 
void SGLBaseCam::recalcEcken()
{
	if(dontTouchEcken>0)
	{
		recalcAngle((Ecken[1]-Ecken[2]).Len()/2);
		dontTouchEcken--;
	}
	else
	{
		SGLVektor PosVektor=getLookVektor();
		
		double DiagWinkel=ATAN(ViewFormat);//Der Winkel der Diagonalen des Sichtfeldes zur Senkrechte
		double high=TAN(Angle/2)*PosVektor.Len(); //Höhe der senkrechten auf dem Horizont berechnen [tan(alpha)=a/b]
		double c = high/COS(DiagWinkel); //die Hypotenuse des Dreiecks aus Diagonalen und der Senkrechte [cos(alpha)=b/c]
		Ecken[0]=UpVect.Rotate(PosVektor,360-DiagWinkel);
		Ecken[1]=UpVect.Rotate(PosVektor,DiagWinkel);
		Ecken[2]=UpVect.Rotate(PosVektor,180-DiagWinkel);
		Ecken[3]=UpVect.Rotate(PosVektor,180+DiagWinkel);
		
		Ecken[0]=(Ecken[0]*c)+LookAt;
		Ecken[1]=(Ecken[1]*c)+LookAt;
		Ecken[2]=(Ecken[2]*c)+LookAt;
		Ecken[3]=(Ecken[3]*c)+LookAt;
	}
}

void SGLBaseCam::recalcAngle(GLdouble height)
{
	Angle=ATAN(height/getLookVektor().Len())*2; // alpha=atan(a/b) (*2 weil wir den Winkel auf der mittelachse berechnet haben, brauchen aber den gesamten Winkel
}

void SGLBaseCam::recalcPos(GLdouble height)
{
	SGLVektor LookVekt=getLookVektor();
	double oldlen=LookVekt.Len();
	double newlen=height/TAN(Angle/2);//b=a/tan(alpha)
	setLookVektor(LookVekt*(newlen /oldlen));// newlen : oldlen = newvek : oldvek => newvek = (newlen : oldlen)*oldvek
}


screen/welt umrechnung
/*!
    \fn SGLBaseCam::setView(unsigned int width,unsigned int height)
 */
void SGLBaseCam::setView(unsigned int width,unsigned int height)
{
	ViewFormat=double(width)/double(height);
	ViewMatr.view[0]=0;
	ViewMatr.view[1]=0;
	ViewMatr.view[2]=width;
	ViewMatr.view[3]=height;
	ViewMatr.outDated=true;//@todo glGetIntegerv(GL_VIEWPORT,view); liefert mist, deshalb von hand
}

bool ViewTrans::screen2welt(const unsigned int x,const unsigned int y,GLdouble depth,SGLVektor &dst)
{
	if(gluUnProject(x,view[3] - int(y) ,depth,model,proj,view,&dst.SGLV_X,&dst.SGLV_Y,&dst.SGLV_Z))return true;
	else{
	SGLprintError("Fehler beim Umrechnen der Coordinaten");
	return false;}
}

