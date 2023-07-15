package com.techshopbe.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import io.jsonwebtoken.Jwts;

public class JWTAuthenticationFilter extends BasicAuthenticationFilter {
	

	private UserDetailsService userDetailsService;
	
	
	public JWTAuthenticationFilter(AuthenticationManager authenticationManager, UserDetailsService userDetailsService) {
		super(authenticationManager);
		// TODO Auto-generated constructor stub
		this.userDetailsService = userDetailsService;
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
			String tokenHeader = request.getHeader("Authorization");
			
			if(tokenHeader != null && tokenHeader.startsWith("Bearer ")) {
				try {
				String token = tokenHeader.replace("Bearer ", "");
				
				
				String email = Jwts
						.parser()
						.setSigningKey("ngocthinh")
						.parseClaimsJws(token)
						.getBody()
						.getSubject();

				
				UserDetails userDetails = userDetailsService.loadUserByUsername(email);
				
				Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
				
				
				SecurityContextHolder.getContext().setAuthentication(authentication);

				} catch (Exception e) {
					
					response.sendError(400, "Token khong dung dinh dang");
				}
				
			}
			chain.doFilter(request, response);
		
	}

}
