package lab4.alarmSystem;

public enum SensorState {
	CLOSED {
		@Override
		protected SensorState nextState() {
			return OPEN;
		}
	},
	OPEN {
		@Override
		protected SensorState nextState() {
			return CLOSED;
		}
	};
	
	protected abstract SensorState nextState();
}
