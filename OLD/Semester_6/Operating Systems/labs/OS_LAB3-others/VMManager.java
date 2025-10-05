


public abstract class VMManager {

    // global constants
    protected final int MAXPROC = VMConstants.MAXPROC;
    protected final int FRAMESIZE  = VMConstants.FRAMESIZE;
    protected final int VMSIZE     = VMConstants.VMSIZE;
    protected final int MEMSIZE  = VMConstants.MEMSIZE;
    protected final int FRAMES  = VMConstants.FRAMES;
 
    // internal data structures
    protected int owner[] = new int[FRAMES];
    protected int page[] = new int[FRAMES];
    protected int accesses[] = new int[MAXPROC+1];
    protected int faults[] = new int[MAXPROC+1];


    // this has to be overwritten
    public abstract boolean access (int PID, int address);
    	
    
    
    // providing information for evaluation classes
    public int owner (int framenumber) 
    {
	return owner[framenumber];
    }
    public int page (int framenumber) 
    {
	return page[framenumber];
    }

    // don't forget to increment these counters appropriately!
    public int accesses(int PID) { return accesses[PID]; }
    public int faults(int PID) { return faults[PID]; }


    // setting it up
    public VMManager () {
	int i,j,frame;

	frame=0;

	for (i=1; i<=MAXPROC; i++) {
	    for (j=0; j<10; j++) {
		owner[frame] = i;
		page[frame]=j;
		frame++;
	    }
	}
	for (; frame<FRAMES; frame++) {
	    owner[frame] = -1;
	    page[frame]=-1;
	}
    }
}