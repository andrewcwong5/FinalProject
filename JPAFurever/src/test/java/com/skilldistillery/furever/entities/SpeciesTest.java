package com.skilldistillery.furever.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class SpeciesTest {
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private Shelter shelter;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("Furever");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		shelter = em.find(Shelter.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		shelter = null;
		em.close();
	}

	@Test
	@DisplayName("Testing Entity mapping")
	void test1() {
		assertNotNull(shelter);
		assertEquals("Dog", shelter.getName());
	}

}
