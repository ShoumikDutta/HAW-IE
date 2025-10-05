package lab4.alarmSystem;

public class SystemApp {

	private static void delayInSec(int delayInSec) throws InterruptedException {
		Thread.sleep(1000L * delayInSec);
	}
	
	public static void main(String[] args) throws InterruptedException {
		int pinCode = 1234;
		//этот вызов создает объект AlarmSystem
		AlarmSystem systemFirst = AlarmSystem.Create(pinCode);
		//а этот уже нет, новый инстанс не создается - он просто возвращает ссылку на ранее созданный
		//не смотря на то, что мы пытались создать system с другим пинкодом и везде ссылаемся на вторую систему с пинкодом 2468
		//фактически мы всегда ссылаемся на систему созданную в переменной systemFirst с пинкодом 1234
		AlarmSystem system = AlarmSystem.Create(pinCode*2);
		//до того, как мы перешли на использование сингелтона
		//эта строчка создавала один объект (instance)
		//AlarmSystem system = new AlarmSystem(pinCode);
		//сейчас нету возможности запретить написать код, который ниже, он позволяет создать еще одну систему
		//в задании просят решить эту проблему
		//эта строчка создавала второй объект (instance)
		//AlarmSystem system2 = new AlarmSystem(pinCode);
		Sensor bathSensor = new Sensor("Bathroom", SensorType.WINDOW, SensorState.CLOSED);
		Sensor floorSensor = new Sensor("Floor", SensorType.DOOR, SensorState.CLOSED);
		
		system.addSensor(bathSensor);
		system.addSensor(floorSensor);
		system.activate();

		delayInSec(20);
		floorSensor.changeState();
		
		delayInSec(20);
		system.deactivate(pinCode + 1);
		delayInSec(5);
		system.deactivate(pinCode);
	}
}
