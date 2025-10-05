package lab4.alarmSystem;

public enum SystemState {
	INACTIVE,
	LEAVING_HOME,
	ACTIVE,
	COMING_HOME,
	ALARM {
		@Override
		protected void entry(AlarmSystem parent) {
			super.entry(parent);	
			parent.setSirenSoundOn(true);
		}

		@Override
		protected void exit(AlarmSystem parent) {
			super.exit(parent);	
			parent.setSirenSoundOn(false);
		}
	};
	
	protected SystemState nextState(AlarmSystem parent, SystemState nextState) {
		exit(parent);
		nextState.entry(parent);
		return nextState;
	};
	
	protected void entry(AlarmSystem parent) {
		System.out.println("<System> State: " + this);
	}
	
	protected void exit(AlarmSystem parent) {
	}
}
