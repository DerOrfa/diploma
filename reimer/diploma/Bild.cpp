template <class T> class Bild
{
	T *data;
	unsigned int xsize,ysize;
	public:
	inline unsigned int size(){return xsize*ysize;}
	Bild(unsigned int x,unsigned int y,T initVal):xsize(x),ysize(y)
	{
		if(initVal==0)data=(T*)calloc(size(),sizeof(T));
		else 
		{
			data=(T*)malloc(size()*sizeof(T));
			for(int i=size()-1;i>=0;i--)data[i]=initVal;
		}
	}
	~Bild(){free(data);}
	inline T &operator[](Punkt &p)		
	{
		assert((p.posx+p.posy*xsize)<size());
		return data[p.posx+p.posy*xsize];
	}
	inline T &operator[](PunktRef &p)
	{
		assert((p.posx+p.posy*xsize)<size());
		return data[p->posx+p->posy*xsize];
	}
};
