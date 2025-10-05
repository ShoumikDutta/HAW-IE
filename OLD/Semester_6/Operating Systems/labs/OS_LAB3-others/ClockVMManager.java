public class ClockVMManager extends VMManager {
	private int next; // next frame pointer
	private boolean[] occupied; //frame bits in use
	
	public ClockVMManager() {
		this.occupied = new boolean[FRAMESIZE];
	}

	public boolean access(int PID, int address) {
		// access to memory is marked
		this.accesses[PID]++;
		address /= this.FRAMESIZE;

		for (int i=0; i<this.FRAMESIZE; i++) {
			// search for the address
			if (this.page[i] == address) {
				// check if PID is in physical memory
				if (this.owner[i] == PID) {
					this.occupied[i] = true;
					this.next = (i + 1) % this.FRAMESIZE;
					return false;	
				//search for an empty page	
				} else if (this.owner[i] == -1) {
					this.page[i] = address;
					this.owner[i] = PID;
					return false;
				}
			}
		}
		//search for an unset used bit
		while (true) {
			// look for a frame with a used bit that is not set
			if (!this.occupied[this.next]) {
				//register fault
				this.faults[PID]++;
				this.owner[this.next] = PID;
				this.page[this.next] = address;
				this.occupied[this.next] = true;
				break;
			}
			this.occupied[this.next++] = false;
			if (this.next == this.FRAMESIZE) this.next = 0;
		}
		return true;
	}

}
