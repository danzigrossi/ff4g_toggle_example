package com.toggle.ff4j.processor;

import org.ff4j.FF4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyClass {

    @Autowired
    private FF4j ff4j;

	@RequestMapping("/teste")
	public ResponseEntity<?> index() {
		if (ff4j.check("TestToggle")) {
			System.out.println("TestToggle: enable");
		}
		return new ResponseEntity<>(HttpStatus.ACCEPTED);
	}
}