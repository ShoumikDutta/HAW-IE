import java.util.LinkedList;

public class FIFOVMManager extends VMManager {
	private LinkedList<Integer> frameIndexes;
	private int last; // the oldest memory frame

	public FIFOVMManager() {
		this.frameIndexes = new LinkedList<Integer>();
		this.last = 0;
	}

	public boolean access(int PID, int address) {
		this.accesses[PID]++; // mark an access to memory
		
		address /= FRAMESIZE;

		for (int i=0; i<this.FRAMESIZE; i++) {
			// search for the address
			if (this.page[i] == address) {
				// check if PID is in physical memory
				if (this.owner[i] == PID) return false;	
				//search for an empty page	
				else if (this.owner[i] == -1) {
					this.page[i] = address;
					this.owner[i] = PID;
					return false;
				}
			}
		}
		// an empty frame can't be found
		// so oldest frame in memory is overwritten
		this.owner[this.last] = PID;
		this.page[this.last] = address;
		this.last++; // increment the oldest frame pointer
		if (this.last == this.FRAMESIZE) this.last = 0;
		this.faults[PID]++; // register fault
		
		return true;
	}

}
