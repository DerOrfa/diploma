void t_dist::lowerCompletion
(deque<pixel> &D,bild<pixelval> &f,bild<unsigned short> &f_LC,bild<short> &idx)
{
	ptr_fifo fifo;
	unsigned short dist=1;
	foreach(pixel,D,p)
	{
		if(p->hasLowerNeighbour(f))
		{
			fifo.push(*p);
			f_LC[p]=numeric_limits<unsigned short>::max();
		}
		else f_LC[p]=0;
	}
	
	fifo.push_null();
	while(!fifo.empty())
	{
		pixel *p=fifo.pop();
		if(p==NULL)
		{
			if(!fifo.empty())
			{
				fifo.push_null();
				assert(dist< numeric_limits<unsigned short>::max());
				dist++;
			}
		}
		else
		{
			f_LC[p]=dist;
			foreach(pixel*,p->neighbours,q)
			{
				if(f[p]==f[*q] && f_LC[*q]==0)
				{
					fifo.push(q);
					f_LC[*q]=numeric_limits<unsigned short>::max();
				}
			}
		}
	}
	foreach(pixel,D,p)
	{
		assert(f_LC[p]<numeric_limits<unsigned short>::max());
		if(f_LC[p]!=0)
			f_LC[p]+=dist*f[p]-1;
		else 
		{
			f_LC[p]=dist * f[p];
			idx[p]=numeric_limits<unsigned short>::max();
		}
	}
}
