package com.skilldistillery.furever.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class FosterReputationTest {
	
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private FosterReputation fr;

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
		fr = em.find(FosterReputation.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		fr = null;
		em.close();
	}

	@Test
	@DisplayName("test foster reputation entity")
	void test1() {
		assertNotNull(fr);
		assertEquals("SOOOOOO GOOOD!!", fr.getContent());
	}
	@Test
	@DisplayName("testing foster reputation user mapping")
	void test2() {
		assertNotNull(fr);
		assertEquals("testUser", fr.getFoster().getUser().getAccount().getUsername());
	}

}
