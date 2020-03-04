using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using godTierCapstoneASP.Models;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;


namespace godTierCapstoneASP.Controllers
{
    public class PostsController : Controller
    {
        private readonly PostContext _context;

        public PostsController(PostContext context)
        {
            _context = context;
        }

        // GET: Posts/Details/5
        [HttpGet]
        [Authorize]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            PostModel post = await _context.Posts.FirstOrDefaultAsync(m => m.id == id);

            if (post == null)
            {
                return NotFound();
            }

            if (post.status != PostStatus.Open)
            {
                int currentUser = getCurrentUserId();
                bool authorized = false;
                if (post.createdBy == currentUser)
                    authorized = true;
                else if (post.acceptedBy != null && post.acceptedBy == currentUser)
                    authorized = true;
                else if (post.deliveredBy != null && post.deliveredBy == currentUser)
                    authorized = true;

                if(authorized == false)
                    return Unauthorized();
            }

            return Ok(post);
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Create([Bind("originLat,originLong,destinationLat,destinationLong,details")] PostModel post)
        {
            if (ModelState.IsValid)
            {
                //if (post.originLat == null || post.originLong == null || post.destinationLat == null || post.destinationLong == null)
                    //return BadRequest();
                post.createdBy = getCurrentUserId();
                _context.Add(post);
                await _context.SaveChangesAsync();
                
                return Ok(post.id);
            }
            return BadRequest();
        }

        [HttpGet]
        [Authorize]
        public JsonResult ViewRecent(int count=50)
        {
            return Json(_context.Posts.Where(p => p.status == PostStatus.Open && p.createdBy != getCurrentUserId()).OrderByDescending(p => p.id).Take(count));
        }

        [HttpPost]
        [Authorize]
        public async Task<ActionResult> Accept(int? id)
        {
            if (id == null)
                return NotFound();

            PostModel post = await _context.Posts.FirstOrDefaultAsync(p => p.id == id);

            if (post == null)
                return NotFound();

            if (post.status == PostStatus.Open)
            {
                if (post.createdBy == getCurrentUserId())
                    return BadRequest();
                post.status = PostStatus.Accepted;
                post.acceptedBy = getCurrentUserId();
                _context.Posts.Update(post);
                await _context.SaveChangesAsync();
                return Ok();
            }
            else
                return BadRequest();
        }

        [HttpPost]
        [Authorize]
        public async Task<ActionResult> Complete(int? id)
        {
            if (id == null)
                return NotFound();

            PostModel post = await _context.Posts.FirstOrDefaultAsync(p => p.id == id);

            if (post == null)
                return NotFound();

            if (post.status == PostStatus.Accepted)
            {
                int currentUser = getCurrentUserId();
                if (post.acceptedBy != currentUser && post.createdBy != currentUser)
                    return Unauthorized();
                post.status = PostStatus.Completed;
                post.deliveredBy = post.acceptedBy;
                _context.Posts.Update(post);
                await _context.SaveChangesAsync();
                return Ok();
            }
            else
                return BadRequest();
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Edit([Bind("id, details, originLat, originLong, destinationLat, destinationLong")] PostModel post)
        {
            PostModel existingPost = await _context.Posts.FirstOrDefaultAsync(m => m.id == post.id);

            if(existingPost == null)
                return BadRequest();
            if (existingPost.status != PostStatus.Open)
                return BadRequest();
            if (existingPost.createdBy != getCurrentUserId())
                return Unauthorized();

            existingPost.details = post.details;
            existingPost.originLat = post.originLat;
            existingPost.originLong = post.originLong;
            existingPost.destinationLat = post.destinationLat;
            existingPost.destinationLong = post.destinationLong;

            _context.Update(existingPost);
            await _context.SaveChangesAsync();
            return Ok();
        }

        // POST: Posts/Delete/5
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
                return BadRequest();

            PostModel post = await _context.Posts.FirstOrDefaultAsync(p => p.id == id);

            if (post == null)
                return BadRequest();

            if (post.status != PostStatus.Open && post.status != PostStatus.Expired)
                return BadRequest();

            if (post.createdBy != getCurrentUserId())
                return Unauthorized();

            post.status = PostStatus.Deleted;
            _context.Update(post);
            await _context.SaveChangesAsync();
            return Ok();
        }

        /// <summary>
        /// returns the id of the currently signed in user
        /// </summary>
        /// <returns></returns>
        private int getCurrentUserId()
        {
            return Convert.ToInt32(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
        }
    }
}
