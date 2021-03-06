package com.skilldistillery.furever.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.furever.entities.Shelter;
import com.skilldistillery.furever.entities.User;
import com.skilldistillery.furever.services.ShelterService;
import com.skilldistillery.furever.services.UserService;

@RestController
@RequestMapping("api/shelter")
@CrossOrigin({"*", "http://localhost:4400"})
public class ShelterController {
	
	@Autowired
	private ShelterService sSvc;

	
	@GetMapping
	private List<Shelter> index() {
		return sSvc.displayAllShelters();
	}	
	
	@GetMapping("{id}")
	private Shelter show(@PathVariable int id, HttpServletResponse response, Principal principal) {
		Shelter s = sSvc.showShelter(id);
		if (s == null) {
			response.setStatus(404);
		}
		return s;
	}
	
	@PostMapping("register")
	public Shelter create(@RequestBody Shelter s, HttpServletResponse response) {
		Shelter s2 = sSvc.createShelter(s);
		if (s2 == null) {
			response.setStatus(500);
		}
		return s2;
	}
	
	@PutMapping("update/{id}")
	public Shelter update(@PathVariable int id, @RequestBody Shelter s, HttpServletResponse response, Principal principal) {
		Shelter s2 = sSvc.updateShelter(s, id, principal);
		if (s2 == null) {
			response.setStatus(404);
		}
		return s2;
	}

}
