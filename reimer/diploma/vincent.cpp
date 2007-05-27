#define INIT -1
void calc_cassic(
	deque<Punkt> &D,Bild<int> &lab,Bild<Punktval> &im,unsigned int size_x,
	unsigned int size_y, VImage &src,VImage &dst,VAttrList &out_list,bool inv
	)
{
	init(size_x,size_y,src,im,D,inv);
	Bild<unsigned int> dist(size_x,size_y,0);
	
	foreach(Punkt,D,p)lab[p]=INIT;

	ptr_fifo fifoA;
	unsigned int curlab=0;
	unsigned int curdistA;

	list< PunktRef>::iterator aktP=D.begin();
	unsigned short h_min=im[**D.begin()];
	unsigned short h_max=im[**D.rbegin()];

	for(Punktval h=h_min;h<=h_max;h++)
	{
		curdistA=1;
		for(list< PunktRef>::iterator p=aktP;p!=D.end() && im[*p]==h;p++)
		{
			lab[*p]=MASK;	//Alle Punkte mit f(p)=h markieren
			bool cont=false;
			//Alle ``Uferpunkte'' (Punkte an Grenze zu Basins) in fifo-Listen ablegen
			foreach(PunktRef,(*p)->neighboursA,q)if(lab[*q]>0 || lab[*q]==WSHED)
			/*wenn p einen Nachbar q hat, der zu mindestens einem erkannten Basin gehoert 
			  -zu einem Unbekannten kann er nich gehoeren
			  -gehoert der Nachbar zu einem Basin, hat per def ein niedrigeres h, da er schon vorher 
			  bearbeitet worden sin muss
			  -steilster anstieg ist Implizit, da niedrigste Pkt zuerst gelabelt werden
			*/
			{
				dist[*p]=1;//Abstand zum naechsten Punkt, der schon "unter wasser" steht
				fifoA.push(*p);
				break;
			}
		}
		fifoA.push_null();

		for(PunktRef p=fifoA.pop();fifoA.size();p=fifoA.pop())
		{
			if(p==PunktRef())
			/* wenn keine ``Uferpunkte'' mehr da, lassen wir das Wasser IN DER EBENE weiterlaufen 
			   (die Pegelhoehe wird hier NICHT erhoeht)*/
			{
				fifoA.push_null();
				curdistA++;
				continue;
			}
			foreach(PunktRef,p->neighboursA,q) // p entsprechend seinen Nachbarn Indizieren
			{
				if(dist[*q]<curdistA && (lab[*q]>0 || lab[*q] == WSHED)) 
				//q ist schon indiziert (gehoert zu mind. einem Basin) und erreichbar
				{
					if(lab[*q]>0)//q gehoert eindeutig zu EINEM Basin
					{
						//wenn p nich eindeutig einem Basin zugeordnet ist
						if(lab[p] == MASK || lab[p] == WSHED)
							lab[p]=lab[*q];//p wird dem Basin von q zugeordnet
						else 
							//wenn Basin von p nicht das Selbe wie das von q ist.
							if(lab[p]!=lab[*q])lab[p]=WSHED;
					}
					else //Wenn q eine Wasserscheide ist 
						//wird p auch eine, wenn es noch keinem Basin zugeordnet ist
						if(lab[p]==MASK)lab[p]=WSHED; 
				}
				else if(lab[*q]==MASK && dist[*q]==0) 
				//q hat selbe Hoehe wie p, ist aber nicht Teil des aktuellen ``Ufers'' =>  Plateau
				{
					dist[*q]=curdistA+1;//Punkte eines Plateaus sind weiter weg vom Wasser
					fifoA.push(*q);
				}
			}
		}

		//neue lokale Minima erkennen
		for(;aktP!=D.end() && im[*aktP]==h;aktP++)
		{
			dist[*aktP]=0;
			//Alle Punkte, die jetzt noch keinem min zugeordnet werden konnten, sind lokale Minima
			if(lab[*aktP]==MASK)
			{
				lab[*aktP]=++curlab;
				fifoA.push(*aktP);
				while(fifoA.size())
				{
					PunktRef q=fifoA.pop();
					foreach(PunktRef,q->neighboursA,r)if(lab[*r]==MASK) 
					{
						fifoA.push(*r);
						lab[*r]=curlab;
					}
				}
			}
		}
	}
}
