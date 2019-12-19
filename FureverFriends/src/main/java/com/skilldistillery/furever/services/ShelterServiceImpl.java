package com.skilldistillery.furever.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.furever.entities.Shelter;
import com.skilldistillery.furever.repositories.ShelterRepository;

@Service
public class ShelterServiceImpl implements ShelterService {
	
	// FIELDS
	
	@Autowired
	private ShelterRepository shelterRepo;
	
	@Override
	public List<Shelter> displayAllShelters() {
		System.out.println(shelterRepo.findAll());
		return shelterRepo.findAll();
	}
	
	@Override
	public Shelter showShelter(int id) {
		return shelterRepo.findById(id);
	}

	@Override
	public Shelter createShelter(Shelter newShelter) {
		try {
			return shelterRepo.saveAndFlush(newShelter);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public Shelter updateShelter(Shelter shelter, int id) {
		Shelter update = shelterRepo.findById(id);
		if (update != null) {
			update.setPhone(shelter.getPhone());
			update.setEmail(shelter.getEmail());
			update.setName(shelter.getName());
			update.setWebsiteUrl(shelter.getWebsiteUrl());
			update.setAddress(shelter.getAddress());
			update.setPets(shelter.getPets());
			update.setUsers(shelter.getUsers());
			update.setImages(shelter.getImages());
			shelterRepo.saveAndFlush(update);
		}
		return update;
	}
}
