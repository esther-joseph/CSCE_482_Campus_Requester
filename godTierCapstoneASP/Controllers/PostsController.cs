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

            return Ok(post);
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Create([Bind("details")] PostModel post)
        {
            if (ModelState.IsValid)
            {
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
            return Json(_context.Posts.Where(p => p.status == PostStatus.Open).OrderByDescending(p => p.id).Take(count));
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
                post.status = PostStatus.Completed;
                _context.Posts.Update(post);
                await _context.SaveChangesAsync();
                return Ok();
            }
            else
                return BadRequest();
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
                post.status = PostStatus.Accepted;
                _context.Posts.Update(post);
                await _context.SaveChangesAsync();
                return Ok();
            }
            else
                return BadRequest();
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Edit([Bind("id, details")] PostModel post)
        {
            PostModel existingPost = await _context.Posts.FirstOrDefaultAsync(m => m.id == post.id);

            if(existingPost == null)
                return BadRequest();
            if (existingPost.status != PostStatus.Open)
                return BadRequest();

            existingPost.details = post.details;

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

            post.status = PostStatus.Deleted;
            _context.Update(post);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
