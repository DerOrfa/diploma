bool setMinLabel(Punkt &p,PunktRef root,int label,Bild<int> &lab)
{
	if(lab[p]==-1)
	{
		lab[p]=label;
		p.sortetNeighbours.insert(pair<double,PunktRef>(0,root));
		foreach(PunktRef,p.neighboursA,q)//Direkte Nachbarn
			setMinLabel(**q,root,label,lab);
		foreach(PunktRef,p.neighboursB,q)//Diagonale Nachbarn
			setMinLabel(**q,root,label,lab);
		return true;
	}
	else return false;
}

void labelMinima(deque<Punkt> &D,Bild<int> &lab)
{
	int label=1;
	foreach(Punkt,D,p)
		if(setMinLabel(*p,p,label,lab))label++;
}
