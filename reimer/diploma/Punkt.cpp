struct Punkt
{
	unsigned short posx,posy;
	Punkt():posx(numeric_limits<unsigned short>::max()),posy(numeric_limits<unsigned short>::max()){}
	deque<PunktRef> neighboursA; /*senkreche/waagerechte Nachbarn im ursprünglichen Graphen*/
	deque<PunktRef> neighboursB; /*diagonale Nachbarn im ursprünglichen Graphen*/
	multimap<double,PunktRef>	sortetNeighbours; /*Nachbarn(aus neighbours*) mit niedrigerem Wert*/
	template <class FT> bool hasLowerNeighbour(Bild<FT> &value_list){
		foreach(PunktRef,neighboursA,p)if(value_list[*p]<value_list[*this])
			return true;
		foreach(PunktRef,neighboursB,p)if(value_list[*p]<value_list[*this])
			return true;
 		return false;
	}
	
};
