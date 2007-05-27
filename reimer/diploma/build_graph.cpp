void buildGraph(deque<Punkt> &D,Bild<unsigned int> &lc)
{
	foreach(Punkt,D,p)
	{
		foreach(PunktRef,p->neighboursA,q)if(lc[p]>lc[*q])//senkrechte und waagerechte Nachbarn
			//lc[p]>lc[*q] => lc[p]-lc[*q] kann nicht negativ sein - keine Pruefung noetig
			p->sortetNeighbours.insert(pair<double,PunktRef>(lc[p]-lc[*q],*q));

		foreach(PunktRef,p->neighboursB,q)if(lc[p]>lc[*q])//diagonale Nachbarn
			//lc[p]>lc[*q] => lc[p]-lc[*q] kann nicht negativ sein - keine Pruefung noetig
			p->sortetNeighbours.insert(pair<double,PunktRef>((lc[p]-lc[*q])/sqrt(2.),*q));
	}
}
