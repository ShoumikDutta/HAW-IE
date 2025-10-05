import java.util.Random;

public class RandomVMManager extends VMManager {
	private Random rand = new Random(1234);

	public boolean access(int PID, int address) {
		this.accesses[PID]++; // mark an access to memory

		address /= FRAMESIZE;

		for (int i=0; i<this.FRAMESIZE; i++) {
			// search for the address
			if (this.page[i] == address) {
				// check if PID is in physical memory
				if (this.owner[i] == PID) {
					return false;	
				//search for an empty page	
				} else if (this.owner[i] == -1) {
					this.page[i] = address;
					this.owner[i] = PID;
					return false;
				}
			}
		}

		// an empty frame can't be found
		// so a random frame in memory is overwritten
		int index = this.rand.nextInt(this.FRAMESIZE - 1) + 1;
		this.page[index] = address;
		this.owner[index] = PID;
		this.faults[PID]++; // register fault

		return true;
	}

}
