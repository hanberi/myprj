package anotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD) //메소드타입에서만 사용
@Retention(RetentionPolicy.RUNTIME) 
//런타임 시점에 어노테이션 적용하겠다. 실행시점에 코드상에 특별한 의미 부여
//해당 클래스란 객체를 통해서 클래스정보 얻어올수있다(Service.class.getDeclaredMethods();)
public @interface PrintAnotation { //어노테이션 이름
	String value() default "-"; //디폴트 엘리먼트
	int number() default 15;	
}//소스코드에서 만들수있음
