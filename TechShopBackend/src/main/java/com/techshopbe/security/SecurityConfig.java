package com.techshopbe.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private UserDetailsService userDetailsService;
	
	@Bean
	@Override
	protected AuthenticationManager authenticationManager() throws Exception {
		// TODO Auto-generated method stub
		return super.authenticationManager();
	}
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.cors();
		http
			.csrf().disable()
			.antMatcher("/api/**")
			.authorizeRequests()
				//.antMatchers("/api/v1/user/**")
				//.hasAnyRole("ADMIN")
				.antMatchers("/api/v1/invoice/**")
				.hasAnyRole("CUSTOMER")
				.antMatchers(HttpMethod.POST, "/api/v1/review/**")
				.hasRole("CUSTOMER")
				.antMatchers("/api/v1/**")
				.permitAll() 
				.anyRequest()
				.authenticated();
		
		http.addFilter(new JWTAuthenticationFilter(authenticationManager(), userDetailsService));
		http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth
			.userDetailsService(userDetailsService)
			.passwordEncoder(new BCryptPasswordEncoder());
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// TODO Auto-generated method stub
		// cau hinh nhung thu ko can kiem tra dang nhap 
		web.ignoring()
		.antMatchers("/v2/api-docs",
				"/configuration/ui",
				"/swagger-resources/**",
				"/configuration/security",
				"/webjars/**",
				"/swagger-ui.html",
				"/upload/**");
	}
}
