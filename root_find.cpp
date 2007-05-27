PunktRef Resolve(PunktRef p,Bild<Punktval> &im)
{
	assert(p->sortetNeighbours.size());
	double LS=p->sortetNeighbours.rbegin()->first;//Der hoechste Key ist maximaler Anstieg == LS(p)
	PunktRef rep= PunktRef()+1;//Der Nachf. einer leeren Punktref. ist wiederum leer (aber ungleich)
	for(multimap<double,PunktRef >::iterator i=p->sortetNeighbours.lower_bound(LS);
		i!=p->sortetNeighbours.end() && rep!=PunktRef();
		i++)
	{
		#define q	i->second
		if(q!=p && q!=PunktRef())
			q=Resolve(q,im,mark);
		if(i==p->sortetNeighbours.lower_bound(LS))//erster Nachbar
			rep=q;
		else if(q!=rep)// Wurzel eines anderen Nachbarn ist verschieden => Wasserscheide
			rep=PunktRef();
		#undef q
	}
	assert(rep!=PunktRef()+1);
	return rep;
}

void unionFind(deque<Punkt> &D,Bild<unsigned int> &lc,Bild<int> &lab,Bild<Punktval> &im)
{
	foreach(Punkt,D,p)
	{
		PunktRef rep;
		rep=Resolve(p,im,false);
		if(rep!=PunktRef())
			lab[p]=lab[rep];
		else
			lab[p]=WSHED;
	}
}
