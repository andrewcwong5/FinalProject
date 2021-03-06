package com.skilldistillery.furever.services;

import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.furever.entities.Pet;
import com.skilldistillery.furever.entities.Shelter;
import com.skilldistillery.furever.repositories.PetRepository;
import com.skilldistillery.furever.repositories.ShelterRepository;

@Service
public class PetServiceImpl implements PetService {
	
	// FIELDS
	
	@Autowired
	private PetRepository petRepo;
	
	@Autowired
	private ShelterRepository shelterRepo;

	// Methods
	
	@Override
	public List<Pet> displayAllPets() {
		return petRepo.findAll();
	}
	
	@Override
	public Pet showPet(int id) {
		Pet pet = null;
		// TODO use findById, check optional.isPresent(), then optional 
		Optional<Pet> opt = petRepo.findById(id);
		if (opt.isPresent()) {
			pet = opt.get();
		}
		return pet;
	}
	@Override
	public Pet getLucky() {
		Pet lucky = null;
				Random rand = new Random();
				List<Pet> pets = petRepo.findAll();
				int numberOfElements = pets.size();
				
				for (int i = 0; i < numberOfElements; i++) {
			        int randomIndex = rand.nextInt(pets.size());
			        lucky = pets.get(randomIndex);
			        pets.remove(randomIndex);
			    }
		return lucky;
	}
	
	@Override
	public Shelter findPetsShelter(int id) {
	Pet pet = null;
	Shelter shelter = null;
		Optional<Pet> opt = petRepo.findById(id);
		if (opt.isPresent()) {
			pet = opt.get();
			shelter = shelterRepo.findByPets_Id(id);
		}
		return shelter;
	}
	
	@Override
	public Pet createPet(Pet pet) {
		Pet opt = petRepo.saveAndFlush(pet);
		return opt;
	}
	
	@Override
	public Pet update(int id, Pet pet) {
		Pet petToUpdate = null;
		Optional<Pet>opt = petRepo.findById(id);
		if (opt.isPresent()) {
			petToUpdate = opt.get();
			petToUpdate.setColor(pet.getColor());
			petToUpdate.setName(pet.getName());
			petToUpdate.setSize(pet.getSize());
			petToUpdate.setAge(pet.getAge());
			petToUpdate.setWeight(pet.getWeight());
			petToUpdate.setAdopted(pet.isAdopted());
			petToUpdate.setFixed(pet.isFixed());
			petRepo.saveAndFlush(petToUpdate);
		}
		return petToUpdate;
	}
	
	@Override
	public boolean deletePet(int id) {
		petRepo.deleteById(id);
		return false;
	}
}
