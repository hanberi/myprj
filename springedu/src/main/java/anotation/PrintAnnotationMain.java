package anotation;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class PrintAnnotationMain {
	
	public static void main(String[] args) {
		//Service 클래스로 부터 메소드 정보를 얻어옮
		Method[] methods = Service.class.getDeclaredMethods();
		//System.out.println(methods.length);
		//각각 메소드를 하나씩 접근
		for(Method method : methods) { 
		//PrintAnnotation이 적용되었는지 확인
			if(method.isAnnotationPresent(PrintAnotation.class)) {
		//PrintAnnotation 객체 얻기
		//해당메소드로부터printAnotation불러옴
				PrintAnotation printAnotation  
					= method.getAnnotation(PrintAnotation.class);
				//메소드이름 출력
				System.out.println("["+method.getName() + "]");
				
				//구분선 출력
				for(int i=0; i<printAnotation.number(); i++) {
					System.out.print(printAnotation.value());
				}
				System.out.println();
				
				//메소드 호출
				try {
					method.invoke(new Service());
					//동일하게 처리할때
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {

					e.printStackTrace();
				}
				//구분선 출력
				for(int i=0; i<printAnotation.number(); i++) {
					System.out.print(printAnotation.value());
				}
				System.out.println();
				
			};
		}
	}
}







