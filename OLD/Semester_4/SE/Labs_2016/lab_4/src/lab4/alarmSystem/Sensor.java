package lab4.alarmSystem;

public class Sensor {
	private final String identifier;
	private SensorType type;
	private SensorState state;
	private AlarmSystem system;

	public Sensor(String identifier, SensorType type, SensorState state) {
		this.identifier = identifier;
		this.type = type;
		this.state = state;
	}

	public String getIdentifier() {
		return identifier;
	}

	public SensorType getType() {
		return type;
	}

	public SensorState getState() {
		return state;
	}

	public void setAlarmSystem(AlarmSystem system) {
		this.system = system;
	}

	public void changeState() {
		state = state.nextState();
		if (system != null) {
			system.sensorChanged(this);
		}
	}
}
