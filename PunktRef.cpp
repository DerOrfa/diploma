class PunktRef
{
	unsigned int id;
public:
	typedef PunktList* PunktRef::*unspecified_bool_type;
	
	PunktRef(unsigned int index):id(cnt){}
	PunktRef():list(NULL){}
	
	Punkt &operator *(){return list->m[id];}
	Punkt *operator ->(){return &(this->operator *());}
	
	PunktRef operator +(unsigned int cnt){return PunktRef(list,id+cnt);}
	PunktRef operator -(unsigned int cnt){return PunktRef(list,id-cnt);}
	
	PunktRef &operator ++(){id++;return *this;}
	PunktRef operator ++(int){PunktRef ret(list,id);id++;return ret;}
  
	operator unspecified_bool_type() const{return list == NULL? NULL: &PunktRef::list;}

	unsigned short PunktRef::getNachb(PunktRef nachb[])
	{
		Punkt p=operator *();

	
		unsigned short size_x=list->size_x;
		unsigned short size_y=list->size_y;
		unsigned short size_z=list->size_z;
	
		unsigned short pCnt=0;
		if(p.posx+1<size_x) /*nich in letzter Spalte*/
			nachb[pCnt++]=PunktRef(id+1);/*östlicher Nachb*/
		if(p.posx)
			nachb[pCnt++]=PunktRef(id-1);/*westlicher Nachb*/
	
		if(p.posy+1<size_y) /*nich in letzter Zeile*/
			nachb[pCnt++]=PunktRef(id+size_x);/* südlicher Nachb */
		if(p.posy) /*nich in letzter Zeile*/
			nachb[pCnt++]=PunktRef(id-size_x);/* nördlicher Nachb */

		if(p.posz+1<size_z) /*nich in letzter Ebene*/
			nachb[pCnt++]=PunktRef(id+size_y*size_x);/*oberer Nachb*/
		if(p.posz) /*nich in letzter Ebene*/
			nachb[pCnt++]=PunktRef(id-size_y*size_x);/*unterer Nachb*/

		return pCnt;
	}
};

