public class LRUVMManager extends VMManager	{
	private int  current;	
	private int  old;
	private int [] frames;

	public LRUVMManager(){
		super();			
		this.frames = new int[this.FRAMESIZE]; 
		this.old = 0;
		this.current = 0;		
	}

	public boolean access(int PID, int address) {
		// increment the counter
		this.accesses[PID]++; 
		//store the page number
		address /= FRAMESIZE;			
		this.current++;
		for(int i=0;i<FRAMESIZE;i++)
			if(this.page[i] == address){
				if(this.owner[i] == PID){
					this.frames[i] = this.current;
					return false;
				}						
				if (this.owner[i]==-1){			
					this.page[i] = address;
					this.owner[i] = PID;
					return false;
				}
			}			
		// Find out Least Recently Used time stamp
		this.old = this.current;		
		for(int i=0;i<this.FRAMESIZE;i++) if(this.frames[i]<this.old) this.old=this.frames[i];

		// increment the fault counter
		this.faults[PID] +=1;		
		//replace the new frame with the old one		
		for(int i=0;i<this.FRAMESIZE;i++)
			if(this.frames[i] <= this.old){
				this.page[i] = address;
				this.owner[i] = PID;
				this.frames[i] = this.current;
				break;
			}				
		return true;
	}
}

